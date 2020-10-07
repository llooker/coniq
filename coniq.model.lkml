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
  sql_always_where: ${test} =0 and ${duplicate} = 0 and ${id_auth_group}=76733 ;;
  always_filter: {filters: [transaction_present.date_redeemed_date:"365 days"]}
  access_filter: {field:transaction_present.id_auth_group
    user_attribute:account}

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

  join: customer_dt {
    view_label: "Customer"
    relationship: many_to_one
    sql_on: ${transaction_present.id_consumer}=${customer_dt.id_consumer} ;;
    }

  join: oma_data{
    relationship: one_to_many
    sql_on: ${auth_location.external_id} = ${oma_data.external_id} and ${auth_location.account_id} = ${oma_data.account_id} and ${oma_data.sale_date_date} = ${transaction_present.date_redeemed_date} ;;
  }

}

explore: oma_data {
  view_label: "OMA data"
}

explore: consumer {
  view_label: "Customers"
  sql_always_where: ${customer_discriminator}='active' ;;
  access_filter: {field:consumer.id_auth_group
    user_attribute:account}

  join: auth_group {
    view_label: "Accounts"
    relationship: many_to_one
    sql_on: ${consumer.id_auth_group} = ${auth_group.id_auth_group} ;;
  }

  join: signup {
    view_label: "Signup Event"
    relationship: many_to_many
    sql_on: ${consumer.id_consumer}=${signup.customer_id} ;;
  }

  join: signup_definition {
    view_label: "Signup Form"
    relationship: many_to_one
    sql_on: ${signup.signup_definition_id} = ${signup_definition.id} ;;
  }
  join: location_group {
    view_label: "Preferred location"
    relationship: one_to_many
    sql_on:  ${consumer.preferred_location_group_id} = ${location_group.id} ;;


  }


}
