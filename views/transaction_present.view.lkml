view: transaction_present {
  sql_table_name: iris.TRANSACTION_present ;;


  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
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



  dimension_group: date_recorded {
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
    sql: ${TABLE}.date_recorded ;;
    datatype: epoch
  }

  dimension_group: date_redeemed {
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
    sql: ${TABLE}.date_redeemed ;;
    datatype: epoch

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



  dimension: price {
    type: number
    sql: ${TABLE}.price ;;
  }


  dimension: refund_amount {
    type: number
    sql: ${TABLE}.refund_amount ;;
  }

  dimension: test {
    type: string
    sql: ${TABLE}.test ;;
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

  dimension: is_revenue {
    type: yesno
    sql: ${price}>0 ;;
  }

  measure: total_price {
    label: "total Spend"
    type: sum
    sql: ${price} ;;
    value_format: "#,##0"
    drill_fields: [detail*]
    filters: [is_revenue: "Yes"]
  }

  dimension: is_this_week {
    type: yesno
    sql: ((( transaction_present.date_redeemed  ) >= (UNIX_TIMESTAMP(TIMESTAMP('2020-09-14')))
    AND ( transaction_present.date_redeemed  ) < (UNIX_TIMESTAMP(TIMESTAMP('2020-09-21'))))) ;;
  }

  dimension: is_previous_week {
    type: yesno
    sql: ((( transaction_present.date_redeemed  ) >= (UNIX_TIMESTAMP(TIMESTAMP('2020-09-21')))
    AND ( transaction_present.date_redeemed  ) < (UNIX_TIMESTAMP(TIMESTAMP('2020-09-27'))))) ;;
  }

  measure: total_spend_this_week {
    type: sum
    sql: ${price} ;;
    value_format: "#,##0"
    drill_fields: [detail*]
    filters: [is_this_week: "Yes"]
  }

  measure: total_spend_previous_week {
    type: sum
    sql: ${price} ;;
    value_format: "#,##0"
    drill_fields: [detail*]
    filters: [is_previous_week: "Yes"]
  }

  measure: total_spend_currency {
    label: "{% if _user_attributes['specific_label'] == 'Yes' %} Total Price currency
    {% else %} Total Spend currency
    {% endif %}"
    type: sum
    sql: ${price} ;;
    value_format: "#,##0"
    filters: [is_revenue: "Yes"]
    drill_fields: [detail*]
    html: {{ location_setting.currency._value }}{{rendered_value}} ;;
    required_access_grants: [can_view_measure]
  }




  measure: count {
    label: "Transaction count"
    type: count
    drill_fields: [price,channel,id_auth_location]
  }

  dimension: is_known_customer {
    type: yesno
    sql: ${id_consumer}>0 and ${id_consumer}<>56796119 ;;
  }

  dimension: visit_id {
    type: string
    sql: case when ${is_known_customer} is true then concat(${id_consumer},${date_redeemed_date}) else null end ;;
  }

  dimension: frequency_bin {
    type: tier
    style: integer
    tiers: [0,1,2,3,5,10]
    sql: ${visit_id} ;;
  }

  measure: total_visits {
    type: count_distinct
    sql: ${visit_id} ;;
    drill_fields: [detail*]
    # drill_fields: [is_known_customer,id_auth_location,price,auth_location.name,location_group.name]
    # filters: [is_known_customer: "Yes"]
  }

  measure: total_customers {
    type: count_distinct
    sql: ${id_consumer} ;;
    drill_fields: [detail*]
    filters: [is_known_customer: "Yes"]
  }


  measure: total_non_zero_transactions{
    type: count
    filters: [is_revenue: "Yes"]
  }

  measure: transaction_ratio {
    type: number
    sql: 1.0*${total_non_zero_transactions}/nullif(${count},0) ;;
  }

  measure: average_Transaction_value {
    type:  average
    sql: ${price} ;;
    value_format_name: eur
    drill_fields: [detail*]
    filters: [is_revenue: "Yes"]
  }

  measure: average_Transaction_value_tooltip {
    type:  average
    sql: ${price} ;;
    value_format_name: eur
    filters: [is_revenue: "Yes"]
    drill_fields: [detail*]
    html: {{rendered_value}} || Total spend {{total_price._rendered_value}} ;;
  }


  measure: count_distinct_customers {
    type: count_distinct
    sql:${id_consumer} ;;
    filters: [is_known_customer: "Yes"]
    drill_fields: [detail*]
  }

  set: detail { fields: [date_redeemed_time,id_consumer,price,channel]

  }

}
