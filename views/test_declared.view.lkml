view: oma_data {
  sql_table_name: report_settings.test_declared ;;
  drill_fields: [revenue
]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: account_id {
    type: number
    sql: ${TABLE}.account_id ;;
  }


  dimension: external_id {
    type: string
    sql: ${TABLE}.external_id ;;
  }

  dimension: no_of_visits {
    type: number
    sql: ${TABLE}.no_of_visits ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }

  dimension_group: sale_date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.sale_date ;;
  }

  dimension: transactions {
    type: number
    sql: ${TABLE}.transactions ;;
  }

  measure: count_of_entries {
    type: count
    drill_fields: [sale_date_date, revenue, transactions]
  }

  measure: total_revenue {
    type: sum
    sql: ${revenue} ;;
    drill_fields: [sale_date_date, revenue, transactions]
  }

  measure : total_transactions {
    type: sum
    sql: ${transactions} ;;
    drill_fields: [sale_date_date, revenue, transactions]
  }

  measure : total_visits {
    type: sum
    sql: ${no_of_visits} ;;
    drill_fields: [sale_date_date, revenue, transactions]
  }
}
