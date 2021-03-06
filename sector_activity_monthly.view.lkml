view: sector_activity_monthly {
  derived_table: {
    datagroup_trigger: coniq_pdt
    sql:  SELECT
  location_group.id as sector_id,
  location_group.label as sector_label,
  date_format(from_unixtime(transaction_present.date_redeemed), '%Y-%m-01')  AS `month_starting`,
  count(id_transaction_present) as all_transactions,
  sum(price) as price,
  count(distinct id_consumer) as visitors
  FROM iris.TRANSACTION_present  AS transaction_present
LEFT JOIN iris.location_group_location  AS location_group_location ON transaction_present.id_auth_location=location_group_location.id_auth_location
LEFT JOIN iris.location_group  AS location_group ON location_group_location.location_group_id=location_group.id and location_group.type='user'
WHERE (location_group.location_group_type_id  = 2) and date_redeemed > unix_timestamp(date(now() - interval 60 day))
AND (transaction_present.test =0 and transaction_present.duplicate = 0 ) AND (NOT (transaction_present.id_auth_group  IS NULL)) and price>0
GROUP BY 1,2,3 ;;
  indexes: ["sector_id"]
  }

  dimension: location_group_id {
    type: number
    sql: ${TABLE}.sector_id ;;
  }

  dimension: location_group_name {
    type: string
    sql: ${TABLE}.sector_label ;;
  }

  dimension_group: month {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.month_starting ;;
    datatype: date
  }

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: concat(${location_group_id},${location_group_name},${month_raw}) ;;
  }

  dimension: price {
    type: number
    sql: ${TABLE}.price ;;
  }

  dimension: all_transactions {
    type: number
    sql: ${TABLE}.all_transactions ;;
  }

  dimension: visitors {
    type: number
    sql: ${TABLE}.visitors ;;
  }

  dimension: atv {
    type: number
    sql: ${price} / ${all_transactions}  ;;
    value_format_name:  decimal_2
  }

  dimension: spc {
    type: number
    sql: ${price} / ${visitors}  ;;
    value_format_name:  decimal_2
  }

  measure : total_price  {
    type :  sum
    sql:  ${price};;
  }

  measure : total_transactions  {
    type :  sum
    sql:  ${all_transactions};;
  }



}
