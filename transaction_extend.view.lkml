include: "/**/*.view.lkml"

view: transaction_extend {
 extends: [transaction_present]


  dimension_group: date_redeemed_local {
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
    sql: convert_tz(${date_redeemed_time},'UTC',${auth_group.timezone});;

  }


 }
