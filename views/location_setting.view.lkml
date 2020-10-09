view: location_setting {
  sql_table_name: report_settings.location_setting ;;

  dimension: account_id {
    type: number
    sql: ${TABLE}.account_id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_on ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: currency_conversion_rate {
    type: number
    sql: ${TABLE}.currency_conversion_rate ;;
  }

  dimension_group: deleted {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.deleted_on ;;
  }

  dimension: language {
    type: string
    sql: ${TABLE}.language ;;
  }

  dimension: location_group_id {
    type: number
    sql: ${TABLE}.location_group_id ;;
  }

  dimension: location_group_short_name {
    type: string
    sql: ${TABLE}.location_group_short_name ;;
  }

  dimension: points_conversion {
    type: number
    sql: ${TABLE}.points_conversion ;;
  }

  dimension: tableau_user {
    type: string
    sql: ${TABLE}.tableau_user ;;
  }

  dimension_group: updated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updated_on ;;
  }

  dimension: vat {
    type: number
    sql: ${TABLE}.vat ;;
  }

  measure: count {
    type: count
    drill_fields: [location_group_short_name]
  }
}
