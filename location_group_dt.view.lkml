view: location_group_dt {
  derived_table: {
    sql_trigger_value: date(now() ;;
    sql: SELECT
        location_group.account_id  AS `account_id`,
        location_group.config  AS `config`,
        location_group.created_on  AS `created_on`,
        location_group.id  AS `group.id`,
        location_group.label  AS `label`,
        location_group.location_group_discriminator  AS `location_group_discriminator`,
        location_group.location_group_key  AS `location_group_key`,
        location_group.location_group_type_id  AS `location_group_type_id`,
        location_group.points_event_rule_id  AS `points_event_rule_id`,
        location_group.type  AS `type`,
        location_group.updated_on  AS `updated_on`,
        location_group_location.id_auth_location  AS `id_auth_location`
      FROM  iris.location_group_location  AS location_group_location
      LEFT JOIN iris.location_group  AS location_group ON location_group_location.location_group_id=location_group.id and location_group.type='user'

      GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12
      ORDER BY location_group.account_id
       ;;
    indexes: ["id_auth_location","account_id"]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: account_id {
    type: number
    sql: ${TABLE}.account_id ;;
  }

  dimension: config {
    type: string
    sql: ${TABLE}.config ;;
  }

  dimension: created_on {
    type: number
    sql: ${TABLE}.created_on ;;
  }

  dimension: group_id {
    type: number
    sql: ${TABLE}.`group.id` ;;
  }

  dimension: label {
    type: string
    sql: ${TABLE}.label ;;
  }

  dimension: location_group_discriminator {
    type: string
    sql: ${TABLE}.location_group_discriminator ;;
  }

  dimension: location_group_key {
    type: string
    sql: ${TABLE}.location_group_key ;;
  }

  dimension: location_group_type_id {
    type: number
    sql: ${TABLE}.location_group_type_id ;;
  }

  dimension: points_event_rule_id {
    type: number
    sql: ${TABLE}.points_event_rule_id ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: updated_on {
    type: number
    sql: ${TABLE}.updated_on ;;
  }

  dimension: id_auth_location {
    type: number
    sql: ${TABLE}.id_auth_location ;;
  }

  set: detail {
    fields: [
      account_id,
      config,
      created_on,
      group_id,
      label,
      location_group_discriminator,
      location_group_key,
      location_group_type_id,
      points_event_rule_id,
      type,
      updated_on,
      id_auth_location
    ]
  }
}
