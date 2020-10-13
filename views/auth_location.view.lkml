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
    link: {
      label: "{{value}} Analytics Dashboard"
      url: "/dashboards/1?Brand={{ value | encode_uri }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }


  dimension: post_code {
    type: zipcode
    sql: ${TABLE}.post_code ;;
  }

  dimension: external_id {
    type: number
    sql: ${TABLE}.external_id ;;
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
