view: customer_activity_dt {
  derived_table: {
    datagroup_trigger: coniq_pdt
    sql: SELECT
        transaction_present.id_consumer  AS id_consumer,
        COUNT(DISTINCT concat(transaction_present.id_consumer,(DATE(FROM_UNIXTIME(transaction_present.date_redeemed ))))) AS `transaction_present.total_visits`,
        COALESCE(SUM(CASE WHEN transaction_present.price>0  THEN transaction_present.price  ELSE NULL END), 0) AS `transaction_present.total_price`,
         min(from_unixtime(transaction_present.date_redeemed)) as First_transaction,
        max(from_unixtime(transaction_present.date_redeemed)) as last_transaction,
        COUNT(CASE WHEN transaction_present.price>0  THEN 1 ELSE NULL END) AS `transaction_present.total_non_zero_transactions`
      FROM iris.TRANSACTION_present  AS transaction_present
      WHERE date_redeemed > unix_timestamp(date(now() - interval 60 day))
      AND (transaction_present.test =0 and transaction_present.duplicate = 0) AND (NOT (transaction_present.id_auth_group  IS NULL)) and id_consumer > 0 and id_consumer <> 56796119 and price > 0
      GROUP BY 1
             ;;
      indexes: ["id_consumer"]
  }



  dimension: id_consumer {
    primary_key: yes
    type: number
    sql: ${TABLE}.id_consumer ;;
  }

  dimension: lifetime_visits {
    type: number
    sql: ${TABLE}.`transaction_present.total_visits` ;;
  }

  dimension_group: first_transaction {
   type:time
  timeframes: [ raw,
      date,
      week,
      month,
      quarter,
      year
]
  sql: ${TABLE}.first_transaction;;
  datatype: epoch
  }

  dimension_group: last_transaction {
    type:time
    timeframes: [ raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.last_transaction;;
    datatype: epoch
  }
  measure: count {
    type: count
  }

  dimension: lifetime_spend {
    type: number
    sql: ${TABLE}.`transaction_present.total_price` ;;
  }

  measure: spend {
    type: sum_distinct
    sql: ${TABLE}.`transaction_present.total_price` ;;
  }
  measure: visit {
    type: sum_distinct
    sql: ${TABLE}.`transaction_present.total_visits` ;;
  }
  measure: scans {
    type: sum_distinct
    sql: ${TABLE}.`transaction_present.total_non_zero_transactions` ;;
  }
  dimension: lifetime_transactions {
    type: number
    sql: ${TABLE}.`transaction_present.total_non_zero_transactions` ;;
  }

  dimension: lifetime_brands_visited {
    type: number
    sql: ${TABLE}.`auth_location.count` ;;
  }

  dimension: spend_bucket  {
    case: {
      when: {
        sql: ${lifetime_spend}=0 ;;
        label: "No spend"

      }
      when: {
        sql: ${lifetime_spend}>0 and ${lifetime_spend}<250 ;;
        label: "0-250"
      }
      when: {
        sql: ${lifetime_spend}>=250 and ${lifetime_spend}<=500 ;;
        label: "250 to 500"
      }
      when: {
        sql: ${lifetime_spend}>=500 and ${lifetime_spend}<=750;;
        label: "500 to 750"
      }
      when: {
        sql: ${lifetime_spend}>=750 and ${lifetime_spend}<=1000 ;;
        label: "750 to 1000"
      }
      when: {
        sql:${lifetime_spend}>1000;;
        label: "above 1000"
      }
    }
  }

    measure: avg_lifetime_visits {
      type: average
      sql: ${lifetime_visits} ;;
    }

    measure: avg_lifetime_spend {
     type: average
      sql: ${lifetime_spend} ;;
    }

    dimension: spend_tiered {
      type: tier
      style: integer
      sql: ${lifetime_spend} ;;
      tiers: [0,250,500,750,1000]
    }

    measure: avg_lifetime_transactions {
      type: average
      sql: ${lifetime_transactions} ;;
    }

    measure: returning_customers  {
      type: count_distinct
      sql: ${id_consumer};;
      filters: [lifetime_visits: ">1"]
    }





}
