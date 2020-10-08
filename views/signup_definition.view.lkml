view: signup_definition {
  sql_table_name: iris.signup_definition ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: auth_group_id {
    type: number
    sql: ${TABLE}.auth_group_id ;;
  }


  dimension_group: last_signup {
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
    sql: ${TABLE}.last_signup_on ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
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

  measure: count {
    type: count
#     drill_fields: [id, name, display_name]
  }
}
