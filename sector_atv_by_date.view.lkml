view: sector_atv_by_date {
  derived_table: {
    sql:  SELECT
  location_group.label ,
  transaction_present.date_redeemed AS `date`,
  location_group_location.id_auth_location  AS `location_id`,
  count(*) as transactions,
  sum(price) as as price
  FROM iris.TRANSACTION_present  AS transaction_present
LEFT JOIN iris.location_group_location  AS location_group_location ON transaction_present.id_auth_location=location_group_location.id_auth_location
LEFT JOIN iris.location_group  AS location_group ON location_group_location.location_group_id=location_group.id and location_group.type='user'

WHERE (((transaction_present.date_redeemed ) >= ((UNIX_TIMESTAMP(DATE_ADD(CURDATE(),INTERVAL -364 day)))) AND (transaction_present.date_redeemed ) <
((UNIX_TIMESTAMP(DATE_ADD(DATE_ADD(CURDATE(),INTERVAL -364 day),INTERVAL 365 day)))))) AND (location_group.location_group_type_id  = 2)
AND (transaction_present.test =0 and transaction_present.duplicate = 0 ) AND (NOT (transaction_present.id_auth_group  IS NULL))
GROUP BY 1,2,3 ;;
  }

  dimension: location_group_name {
    type: string
    sql: ${location_group.label} ;;
  }

  dimension: location_id {
    type: number
    sql: ${location_id} ;;
  }

  dimension: price {
    type: number
    sql: ${price} ;;
  }

  measure : total_price  {
    type :  sum
    sql:  ${price};;
  }

  measure : total_transactions  {
    type :  sum
    sql:  ${total_transactions};;
  }

  measure: sector_atv{
    type:  average
    sql: ${price}  ;;
    value_format_name: decimal_2
  }

}
