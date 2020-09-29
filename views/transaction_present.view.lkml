view: transaction_present {
  sql_table_name: iris.TRANSACTION_present ;;

  dimension: by_handset {
    type: yesno
    sql: ${TABLE}.by_handset ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: commission {
    type: number
    sql: ${TABLE}.commission ;;
  }

  dimension: consumer_name {
    type: string
    sql: ${TABLE}.consumer_name ;;
  }

  dimension: current_status {
    type: string
    sql: ${TABLE}.current_status ;;
  }

  dimension_group: current_status {
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
    sql: ${TABLE}.current_status_on ;;
  }

  dimension_group: date_handset {
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
    sql: ${TABLE}.date_handset ;;
  }

  dimension: date_recorded {
    type: number
    sql: ${TABLE}.date_recorded ;;
  }

  dimension: date_redeemed {
    type: number
    sql: ${TABLE}.date_redeemed ;;
  }

  dimension_group: redeemed {
    type: time
    sql: ${date_redeemed} ;;
 datatype: epoch

  }

  dimension_group: date_scanned {
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
    sql: ${TABLE}.date_scanned ;;
  }

  dimension: duplicate {
    type: string
    sql: ${TABLE}.duplicate ;;
  }

  dimension: id_action {
    type: number
    sql: ${TABLE}.id_action ;;
  }

  dimension: id_auth_group {
    type: number
    sql: ${TABLE}.id_auth_group ;;
#     timezone is in auth_group linked with this table
  }

  dimension: id_auth_location {
    type: number
    sql: ${TABLE}.id_auth_location ;;
  }

  dimension: id_barcode {
    type: number
    sql: ${TABLE}.id_barcode ;;
  }

  dimension: id_consumer {
    type: number
    sql: ${TABLE}.id_consumer ;;
  }

  dimension: id_handset {
    type: number
    sql: ${TABLE}.id_handset ;;
  }

  dimension: id_transaction_present {
    primary_key: yes
    type: number
    sql: ${TABLE}.id_transaction_present ;;
  }

  dimension: imei {
    type: string
    sql: ${TABLE}.imei ;;
  }

  dimension: linked_payment_method_id {
    type: number
    sql: ${TABLE}.linked_payment_method_id ;;
  }

  dimension: location_address {
    type: string
    sql: ${TABLE}.location_address ;;
  }

  dimension: manual_entry_enc {
    type: string
    sql: ${TABLE}.manual_entry_enc ;;
  }

  dimension: price {
    type: number
    sql: ${TABLE}.price ;;
  }

  dimension: price_source {
    type: string
    sql: ${TABLE}.price_source ;;
  }

  dimension: refund_amount {
    type: number
    sql: ${TABLE}.refund_amount ;;
  }

  dimension: test {
    type: string
    sql: ${TABLE}.test ;;
  }

  dimension: total {
    type: number
    sql: ${TABLE}.total ;;
  }

  dimension: transaction_values {
    type: string
    sql: ${TABLE}.transaction_values ;;
  }

  dimension: type_trans {
    type: yesno
    sql: ${TABLE}.type_trans ;;
  }

  dimension: unique_id {
    type: string
    sql: ${TABLE}.unique_id ;;
  }

  dimension_group: verified {
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
    sql: ${TABLE}.verified_on ;;
  }

  dimension: via {
    type: string
    sql: ${TABLE}.via ;;
  }

  dimension: is_revenue {
    type: yesno
    sql: ${price}>0 ;;
  }

  measure: total_price {
    type: sum
    sql: ${price} ;;
    filters: [is_revenue: "Yes"]
  }

  measure: count {
    label: "Transaction count"
    type: count
    drill_fields: [consumer_name,price,channel,id_auth_location]
  }

  dimension: is_known_customer {
    type: yesno
    sql: ${id_consumer}>0 and ${id_consumer}<>56796119 ;;
  }

  dimension: visit {
    type: string
    sql: case when ${is_known_customer} is true then concat(${id_consumer},${redeemed_date}) else null end ;;
  }

  measure: total_visits {
    type: count_distinct
    sql: ${visit} ;;
    filters: [is_known_customer: "Yes"]
  }

  measure: total_customers {
    type: count_distinct
    sql: ${id_consumer} ;;
    filters: [is_known_customer: "Yes"]
  }




  measure: total_non_zero_transactions{
    type: count
    filters: [is_revenue: "Yes"]
  }
}
