view: auth_group {
  sql_table_name: iris.AUTH_group ;;


  dimension: disabled_on {
    type: number
    sql: ${TABLE}.disabled_on ;;
  }

  dimension: id_auth_group {
    primary_key: yes
    type: number
    sql: ${TABLE}.id_auth_group ;;
  }

  dimension: id_parent {
    view_label: "parent_account_id"
    type: number
    sql: ${TABLE}.id_parent ;;
  }

  dimension: is_test {
    type: yesno
    sql: ${TABLE}.is_test ;;
  }

  dimension: label {
    type: string
    sql: ${TABLE}.label ;;
  }

  dimension: postcode {
    type: string
    sql: ${TABLE}.postcode ;;
  }


  dimension: timezone {
    type: string
    sql: ${TABLE}.timezone ;;
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
    drill_fields: []
  }
}
