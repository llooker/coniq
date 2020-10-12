view: consumer {
  sql_table_name: iris.CONSUMER ;;




  dimension_group: created_on {
    type: time
    timeframes: [
       raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_on ;;
    datatype: epoch

  }

  dimension: customer_data {
    type: string
    sql: ${TABLE}.customer_data ;;
  }

  dimension: customer_discriminator {
    type: string
    sql: ${TABLE}.customer_discriminator ;;
  }


  dimension_group: date_of_birth {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_of_birth ;;
  }

  dimension: age {
    type:  duration_year
    sql_start: ${date_of_birth_date} ;;
    sql_end: current_timestamp() ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [0,10,20,30,40,50,60,70,80]
    style: integer
    sql: ${age} ;;
  }

  dimension: deliverable {
    description: "this is the name of the product where the cusotmer paid for"
    type: string
    sql: ${TABLE}.deliverable ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender;;
  }

  dimension: id_auth_group {
    type: number
    sql: ${TABLE}.id_auth_group ;;
  }

  dimension: id_consumer {
    primary_key: yes
    type: number
    sql: ${TABLE}.id_consumer ;;
  }

  dimension: id_ff_channel {
    type: number
    sql: ${TABLE}.id_ff_channel ;;
  }

  dimension: postcode {
    type: zipcode
    sql: ${TABLE}.postcode ;;
  }

  dimension: preferred_language_code {
    type: string
    sql: ${TABLE}.preferred_language_code ;;
  }

  dimension: preferred_location_group_id {
    type: number
    sql: ${TABLE}.preferred_location_group_id ;;
  }

  dimension: town {
    type: string
    sql: ${TABLE}.town ;;
  }

  dimension: updated_on {
    type: number
    sql: ${TABLE}.updated_on ;;
  }


  measure: count {
    type: count
  }

}
