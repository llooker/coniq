view: location_group_location {
  sql_table_name: iris.location_group_location ;;

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

  dimension: id_auth_location {
    type: number
    sql: ${TABLE}.id_auth_location ;;
  }

  dimension: location_group_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.location_group_id ;;
  }

  dimension: primary_key {
    primary_key: yes
    type: string
    sql: concat(${id_auth_location},${location_group_id}) ;;
  }

  measure: count {
    type: count
    drill_fields: [location_group.id]
  }
}
