view: location_group {
  sql_table_name: iris.location_group ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: account_id {
    type: number
    sql: ${TABLE}.account_id ;;
  }

  dimension: config {
    type: string
    sql: ${TABLE}.config ;;
  }

  dimension: created_on {
    type: number
    sql: ${TABLE}.created_on ;;
  }

  dimension: label {
    type: string
    sql: ${TABLE}.label ;;
  }

  dimension: location_group_discriminator {
    type: string
    sql: ${TABLE}.location_group_discriminator ;;
  }

  dimension: location_group_key {
    type: string
    sql: ${TABLE}.location_group_key ;;
  }

  dimension: location_group_type_id {
    type: number
    sql: ${TABLE}.location_group_type_id ;;
  }

  dimension: points_event_rule_id {
    type: number
    sql: ${TABLE}.points_event_rule_id ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: updated_on {
    type: number
    sql: ${TABLE}.updated_on ;;
  }

  measure: count {
    type: count
    drill_fields: [id, location_group_location.count]
  }
}
