view: consumer {
  sql_table_name: iris.CONSUMER ;;

  dimension: address {
    type: string
    sql: ${TABLE}.address ;;
  }

  dimension: address2 {
    type: string
    sql: ${TABLE}.address2 ;;
  }

  dimension: allow_email {
    type: yesno
    sql: ${TABLE}.allow_email ;;
  }

  dimension: allow_post {
    type: yesno
    sql: ${TABLE}.allow_post ;;
  }

  dimension: allow_sms {
    type: yesno
    sql: ${TABLE}.allow_sms ;;
  }

  dimension: allow_third_party {
    type: yesno
    sql: ${TABLE}.allow_third_party ;;
  }

  dimension: block_all {
    type: yesno
    sql: ${TABLE}.block_all ;;
  }

  dimension: carrier {
    type: string
    sql: ${TABLE}.carrier ;;
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

  dimension: created_on {
    type: number
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

  dimension: customer_title {
    type: string
    sql: ${TABLE}.customer_title ;;
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

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: email_verified {
    type: string
    sql: ${TABLE}.email_verified ;;
  }

  dimension: external_id {
    type: string
    sql: ${TABLE}.external_id ;;
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

  dimension: is_email_blocked {
    type: yesno
    sql: ${TABLE}.is_email_blocked ;;
  }

  dimension: marketing_agreement {
    type: yesno
    sql: ${TABLE}.marketing_agreement ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: phone_country_code {
    type: string
    sql: ${TABLE}.phone_country_code ;;
  }

  dimension: phone_number {
    type: string
    sql: ${TABLE}.phone_number ;;
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

  dimension: public_id {
    type: string
    sql: ${TABLE}.public_id ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
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

  measure: count {
    type: count
    drill_fields: [name]
  }
}
