connection: "prodreplica"

include: "/**/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/view.lkml"                   # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }

explore: transaction_present {
  view_label: "Transactions"
  sql_always_where: date_redeemed > unix_timestamp(date(now() - interval 6 day)) ;;

  join: auth_group {
    view_label: "Accounts"
    relationship: many_to_one
    sql_on: ${transaction_present.id_auth_group}=${auth_group.id_auth_group} ;;
  }


  join: auth_location {
    view_label: "Locations"
    relationship: many_to_one
    sql_on: ${transaction_present.id_auth_location}=${auth_location.id_auth_location} ;;

  }

  join: location_group_location {
    view_label: "Location to location_group"
    relationship: many_to_many
    sql_on: ${transaction_present.id_auth_location}=${location_group_location.id_auth_location} ;;
  }

  join: location_group {
    view_label: "Location Group"
    relationship: many_to_many
    sql_on: ${location_group_location.location_group_id}=${location_group.id} and ${location_group.type}='user';;
  }

  join: visit_facts_dt {
    view_label: "Visits"
    relationship: many_to_one
    sql_on: ${transaction_present.visit}=${visit_facts_dt.visit} ;;
  }

}

explore: consumer {
  view_label: "Customers"
  sql_always_where: ${customer_discriminator}='active' ;;
}
