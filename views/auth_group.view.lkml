view: auth_group {
  sql_table_name: iris.AUTH_group ;;

  dimension: account_manager_id {
    type: number
    sql: ${TABLE}.account_manager_id ;;
  }

  dimension: account_type_id {
    type: number
    sql: ${TABLE}.account_type_id ;;
  }

  dimension: address {
    type: string
    sql: ${TABLE}.address ;;
  }

  dimension: average_transaction_value {
    type: number
    sql: ${TABLE}.average_transaction_value ;;
  }

  dimension: bg_color {
    type: string
    sql: ${TABLE}.bg_color ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: company {
    type: string
    sql: ${TABLE}.company ;;
  }

  dimension: company_url {
    type: string
    sql: ${TABLE}.company_url ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: created_on {
    type: number
    sql: ${TABLE}.created_on ;;
  }

  dimension: data_controller_statement {
    type: string
    sql: ${TABLE}.data_controller_statement ;;
  }

  dimension: data_handoff {
    type: string
    sql: ${TABLE}.data_handoff ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: disabled_on {
    type: number
    sql: ${TABLE}.disabled_on ;;
  }

  dimension: double_opt_in {
    type: yesno
    sql: ${TABLE}.double_opt_in ;;
  }

  dimension: double_opt_in_config {
    type: string
    sql: ${TABLE}.double_opt_in_config ;;
  }

  dimension: external_barcode_offer_id {
    type: number
    sql: ${TABLE}.external_barcode_offer_id ;;
  }

  dimension: handset_config {
    type: string
    sql: ${TABLE}.handset_config ;;
  }

  dimension: has_email {
    type: yesno
    sql: ${TABLE}.has_email ;;
  }

  dimension: has_post {
    type: yesno
    sql: ${TABLE}.has_post ;;
  }

  dimension: has_repermission_at_scanner {
    type: yesno
    sql: ${TABLE}.has_repermission_at_scanner ;;
  }

  dimension: has_reward_require_registration_enabled {
    type: yesno
    sql: ${TABLE}.has_reward_require_registration_enabled ;;
  }

  dimension: has_sms {
    type: yesno
    sql: ${TABLE}.has_sms ;;
  }

  dimension: has_third_party {
    type: yesno
    sql: ${TABLE}.has_third_party ;;
  }

  dimension: id_auth_group {
    primary_key: yes
    type: number
    sql: ${TABLE}.id_auth_group ;;
  }

  dimension: id_auth_location {
    type: number
    sql: ${TABLE}.id_auth_location ;;
  }

  dimension: id_parent {
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

  dimension: logo {
    type: string
    sql: ${TABLE}.logo ;;
  }

  dimension: minimum_age_restriction {
    type: number
    sql: ${TABLE}.minimum_age_restriction ;;
  }

  dimension: password_reset_email {
    type: number
    sql: ${TABLE}.password_reset_email ;;
  }

  dimension: points_program_access_on {
    type: number
    sql: ${TABLE}.points_program_access_on ;;
  }

  dimension: postcode {
    type: string
    sql: ${TABLE}.postcode ;;
  }

  dimension: repermission_config {
    type: string
    sql: ${TABLE}.repermission_config ;;
  }

  dimension: sage_id {
    type: string
    sql: ${TABLE}.sage_id ;;
  }

  dimension: show_marketing_prefs_at_repermission {
    type: yesno
    sql: ${TABLE}.show_marketing_prefs_at_repermission ;;
  }

  dimension: stamp_program_access_on {
    type: number
    sql: ${TABLE}.stamp_program_access_on ;;
  }

  dimension: tax_free_enabled {
    type: yesno
    sql: ${TABLE}.tax_free_enabled ;;
  }

  dimension: tiered_reward_program_access_on {
    type: number
    sql: ${TABLE}.tiered_reward_program_access_on ;;
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

  dimension: upload_config {
    type: string
    sql: ${TABLE}.upload_config ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
