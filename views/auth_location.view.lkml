view: auth_location {
  sql_table_name: iris.AUTH_location ;;

  dimension: account_id {
    type: number
    sql: ${TABLE}.account_id ;;
  }

  dimension_group: activation_first_sent {
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
    sql: ${TABLE}.activation_first_sent_on ;;
  }

  dimension_group: activation_last_sent {
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
    sql: ${TABLE}.activation_last_sent_on ;;
  }

  dimension: address {
    type: string
    sql: ${TABLE}.address ;;
  }

  dimension: address2 {
    type: string
    sql: ${TABLE}.address2 ;;
  }

  dimension: average_transaction_value {
    type: number
    sql: ${TABLE}.average_transaction_value ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: comment {
    type: string
    sql: ${TABLE}.comment ;;
  }

  dimension: contact_person {
    type: string
    sql: ${TABLE}.contact_person ;;
  }

  dimension: contact_phone {
    type: string
    sql: ${TABLE}.contact_phone ;;
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

  dimension: created_on {
    type: number
    sql: ${TABLE}.created_on ;;
  }

  dimension: deleted_on {
    type: number
    sql: ${TABLE}.deleted_on ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: external_id {
    type: string
    sql: ${TABLE}.external_id ;;
  }

  dimension: fax {
    type: string
    sql: ${TABLE}.fax ;;
  }

  dimension: id_auth_location {
    primary_key: yes
    type: number
    sql: ${TABLE}.id_auth_location ;;
  }

  dimension: id_barcode {
    type: number
    sql: ${TABLE}.id_barcode ;;
  }

  dimension: id_language {
    type: number
    sql: ${TABLE}.id_language ;;
  }

  dimension: logo {
    type: string
    sql: ${TABLE}.logo ;;
  }

  dimension: map_lat {
    type: string
    sql: ${TABLE}.map_lat ;;
  }

  dimension: map_long {
    type: string
    sql: ${TABLE}.map_long ;;
  }

  dimension: mobile_phone {
    type: string
    sql: ${TABLE}.mobile_phone ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: photo {
    type: string
    sql: ${TABLE}.photo ;;
  }

  dimension: post_code {
    type: string
    sql: ${TABLE}.post_code ;;
  }

  dimension: prefix {
    type: string
    sql: ${TABLE}.prefix ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }

  dimension: status {
    type: number
    sql: ${TABLE}.status ;;
  }

  dimension: supplier_data {
    type: string
    sql: ${TABLE}.supplier_data ;;
  }

  dimension: tax_free_supplier_id {
    type: number
    sql: ${TABLE}.tax_free_supplier_id ;;
  }

  dimension: town {
    type: string
    sql: ${TABLE}.town ;;
  }

  dimension: updated_on {
    type: number
    sql: ${TABLE}.updated_on ;;
  }

  dimension: website {
    type: string
    sql: ${TABLE}.website ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}
