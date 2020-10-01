view: consumer {
  sql_table_name: iris.CONSUMER ;;




  dimension_group: created_on {
    type: time
    sql: ${TABLE}.created_on ;;
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

  dimension: deleted_on {
    type: number
    sql: ${TABLE}.deleted_on ;;
  }

  dimension: deliverable {
    type: string
    sql: ${TABLE}.deliverable ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: id_auth_group {
    type: number
    sql: ${TABLE}.id_auth_group ;;
  }

  dimension: id_consumer {
    type: number
    sql: ${TABLE}.id_consumer ;;
  }

  dimension: id_ff_channel {
    type: number
    sql: ${TABLE}.id_ff_channel ;;
  }

  dimension: postcode {
    type: string
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

  dimension: var1 {
    type: string
    sql: ${TABLE}.var1 ;;
  }

  dimension: var2 {
    type: string
    sql: ${TABLE}.var2 ;;
  }

  dimension: var3 {
    type: string
    sql: ${TABLE}.var3 ;;
  }

  dimension: var4 {
    type: string
    sql: ${TABLE}.var4 ;;
  }

  dimension: var5 {
    type: string
    sql: ${TABLE}.var5 ;;
  }


}
