view: customer_activity_dt {
  derived_table: {
    datagroup_trigger: coniq_pdt
    sql: SELECT
        transaction_present.id_consumer  AS id_consumer,
        COUNT(DISTINCT concat(transaction_present.id_consumer,(DATE(FROM_UNIXTIME(transaction_present.date_redeemed ))))) AS `transaction_present.total_visits`,
        COALESCE(SUM(CASE WHEN transaction_present.price>0  THEN transaction_present.price  ELSE NULL END), 0) AS `transaction_present.total_price`,
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

  dimension: lifetime_spend {
    type: number
    sql: ${TABLE}.`transaction_present.total_price` ;;
  }

  dimension: lifetime_transactions {
    type: number
    sql: ${TABLE}.`transaction_present.total_non_zero_transactions` ;;
  }

  dimension: lifetime_brands_visited {
    type: number
    sql: ${TABLE}.`auth_location.count` ;;
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

    dimension: transaction_bin {
    type: tier
    style: integer
    sql: ${lifetime_transactions} ;;
    tiers: [2,4,6,8,10,20]
  }

    measure: avg_lifetime_transactions {
      type: average
      sql: ${lifetime_transactions} ;;
    }

    measure: avg_lifetime_brands_visited {
      type: average
      sql: ${lifetime_brands_visited} ;;
    }

    measure: count {
    type: count
  }
}
