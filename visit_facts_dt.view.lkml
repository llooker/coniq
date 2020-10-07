view: visit_facts_dt {
  derived_table: {
    sql_trigger_value: date(now() ;;
    sql: SELECT
        concat(transaction_present.id_consumer,(DATE(from_unixtime(transaction_present.date_redeemed) )))   AS visit,
        count(distinct concat(transaction_present.id_consumer,(DATE(from_unixtime(transaction_present.date_redeemed) )))) as frequency,
        COUNT(*) AS `transaction_present.count`,
        COALESCE(SUM(CASE WHEN transaction_present.price>0  THEN transaction_present.price  ELSE NULL END), 0) AS `transaction_present.total_price`
      FROM iris.TRANSACTION_present  AS transaction_present

      WHERE date_redeemed > unix_timestamp(date(now() - interval 365 day))  and test = 0 and duplicate = 0 and transaction_present.id_consumer>0 and transaction_present.id_consumer<>56796119
      GROUP BY 1
       ;;
    indexes: ["visit"]
  }

  measure: count {
    type: count
  }

  dimension: visit {
    primary_key: yes
    type: string
    sql: ${TABLE}.visit ;;
  }

  dimension: transactions_per_visit {
    type: number
    sql: ${TABLE}.`transaction_present.count` ;;
  }

  dimension: spend_per_visit{
    type: number
    sql: ${TABLE}.`transaction_present.total_price` ;;
  }

  dimension: frequency{
    type: number
    sql: ${TABLE}.`transaction_present.frequency` ;;
  }

  measure: average_transaction_per_visit {
    type: average
    sql: ${transactions_per_visit} ;;
    value_format_name: decimal_2
  }

  measure: average_spend_per_visit {
    type: average
    sql: ${spend_per_visit} ;;
    value_format_name: decimal_2
  }


}
