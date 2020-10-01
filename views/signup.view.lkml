view: signup {
  sql_table_name: iris.signup ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: activation {
    type: string
    sql: ${TABLE}.activation ;;
  }

  dimension: auth_group_id {
    type: number
    sql: ${TABLE}.auth_group_id ;;
  }

  dimension: channel_id {
    type: number
    sql: ${TABLE}.channel_id ;;
  }

  dimension: customer_data {
    type: string
    sql: ${TABLE}.customer_data ;;
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension: is_replacement {
    type: yesno
    sql: ${TABLE}.is_replacement ;;
  }

  dimension: privacy_agreement {
    type: yesno
    sql: ${TABLE}.privacy_agreement ;;
  }

  dimension: referral_code_id {
    type: number
    sql: ${TABLE}.referral_code_id ;;
  }

  dimension: referral_code_used {
    type: string
    sql: ${TABLE}.referral_code_used ;;
  }

  dimension_group: signed_up {
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
    sql: ${TABLE}.signed_up_on ;;
  }

  dimension: signup_definition_id {
    type: number
    sql: ${TABLE}.signup_definition_id ;;
  }

  dimension: source_reference {
    type: string
    sql: ${TABLE}.source_reference ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
