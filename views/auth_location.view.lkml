view: auth_location {
  sql_table_name: iris.AUTH_location ;;

  dimension: account_id {
    type: number
    sql: ${TABLE}.account_id ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: county {
    type: string
    sql: ${TABLE}.county ;;
  }

  dimension: deleted_on {
    type: number
    sql: ${TABLE}.deleted_on ;;
  }



  dimension: id_auth_location {
    primary_key: yes
    type: number
    sql: ${TABLE}.id_auth_location ;;
  }


  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }


  dimension: post_code {
    type: string
    sql: ${TABLE}.post_code ;;
  }

  dimension: prefix {
    type: string
    sql: ${TABLE}.prefix ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}
