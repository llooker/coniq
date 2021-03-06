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

access_grant: can_view_measure {
  user_attribute: can_see_local_currency
  allowed_values: ["Yes"]
}

access_grant: specific_label {
  user_attribute: specific_label
  allowed_values: ["Yes"]
}

datagroup: coniq_pdt {
  label: "Update Trigger"
  description: "datagroup to refresh all pdts every day"
  max_cache_age: "24 hours"
  sql_trigger: select date(now()) ;;
}

explore: transaction_present {
  from: transaction_extend
  view_label: "Transactions"
  always_filter: {filters: [transaction_present.date_redeemed_date: "60 days"]}
  sql_always_where: ${test} =0 and ${duplicate} = 0 ;;

  access_filter: {field:transaction_present.id_auth_group
    user_attribute:account}

  join: auth_group {
    view_label: "Accounts"
    relationship: many_to_one
    sql_on: ${transaction_present.id_auth_group}=${auth_group.id_auth_group} ;;
  }


  join: auth_location {
    view_label: "Brand"
    relationship: many_to_one
    sql_on: ${transaction_present.id_auth_location}=${auth_location.id_auth_location} ;;

  }

  # join: location_group_location {
  #   view_label: "Location to location_group"
  #   relationship: many_to_many
  #   sql_on: ${transaction_present.id_auth_location}=${location_group_location.id_auth_location} ;;
  # }

  # join: location_group {
  #   view_label: "Location Group"
  #   relationship: many_to_many
  #   sql_on: ${location_group_location.location_group_id}=${location_group.id} and ${location_group.type}='user';;
  # }

  join: location_group_dt {
    view_label: "Shopping Centre"
    relationship: many_to_one
    sql_on:  ${transaction_present.id_auth_location}=${location_group_dt.id_auth_location};;
  }

  join: visit_facts_dt {
    view_label: "Visits"
    relationship: many_to_one
    sql_on: ${transaction_present.visit_id}=${visit_facts_dt.visit_id} ;;
  }

  join: consumer {
    view_label: "Customer"
    relationship: many_to_one
    sql_on: ${transaction_present.id_consumer}=${consumer.id_consumer} ;;
    }

  join: oma_data{
    relationship: many_to_many
    sql_on: ${auth_location.external_id} = ${oma_data.external_id} and ${auth_location.account_id} = ${oma_data.account_id} and ${oma_data.sale_date_date} = ${transaction_present.date_redeemed_date} ;;
  }


  join: location_setting {
    view_label: "Transactions"
    relationship: many_to_one
    sql_on: ${location_group_dt.account_id}=${location_setting.account_id} ;;
    }
  join: sector_activity_monthly {
    relationship: many_to_one
    sql_on: ${location_group_dt.id} = ${sector_activity_monthly.location_group_id} and ${transaction_present.date_redeemed_month} = ${sector_activity_monthly.month_month} and ${transaction_present.date_redeemed_year} = ${sector_activity_monthly.month_year}  ;;

  }
}

explore: oma_data {
  view_label: "OMA data"
  join : auth_location{
    view_label: "Coniq locations"
    relationship: many_to_one
    sql_on: ${auth_location.external_id} = ${oma_data.external_id} and ${auth_location.account_id} = ${oma_data.account_id} ;;
  }

  join: transaction_present {
    view_label: "Coniq transactions"
    relationship: many_to_many
    sql_on:${auth_location.id_auth_location} = ${transaction_present.id_auth_location} and ${oma_data.sale_date_date} = ${transaction_present.date_redeemed_date} ;;
  }
  join: auth_group {
    view_label: "Account"
    relationship: many_to_one
    sql_on: ${oma_data.account_id} = ${auth_group.id_auth_group} ;;
  }

}

explore: consumer {
  view_label: "Customers"
  sql_always_where: ${customer_discriminator}='active' ;;
  always_filter: {filters:[consumer.created_on_date:"60 days"]}
  access_filter: {field:consumer.id_auth_group
    user_attribute:account}

  join: auth_group {
    view_label: "Accounts"
    relationship: many_to_one
    sql_on: ${consumer.id_auth_group} = ${auth_group.id_auth_group} ;;
  }

  join: transaction_present {
    view_label: "Transactions"
    relationship: many_to_one
    sql_on: ${consumer.id_consumer} = ${transaction_present.id_consumer} ;;
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
  join: customer_activity_dt
  {view_label:"customer_activity"
    relationship: many_to_one
    sql_on: ${consumer.id_consumer}=${customer_activity_dt.id_consumer} ;;
    }

}


explore: visit_facts_dt {
  view_label: "Visits"
  access_filter: {field:visit_facts_dt.account_id
    user_attribute:account}

  join : transaction_present {
    view_label: "Transactions"
    relationship: one_to_many
    sql_on: ${transaction_present.visit_id}= ${visit_facts_dt.visit_id} ;;
  }

  join: consumer {
    view_label: "Customers"
    relationship: many_to_one
    sql_on: ${visit_facts_dt.customer_id} = ${consumer.id_consumer} ;;
  }

  join: auth_group {
    view_label: "Account"
    relationship: many_to_one
    sql_on: ${visit_facts_dt.account_id} = ${auth_group.id_auth_group} ;;
  }
}



# AGG AWARENESS:

explore: +transaction_present {
  aggregate_table: rollup__auth_location_name__channel__date_redeemed_date__location_group_dt_label {
    query: {
      dimensions: [
        transaction_present.id_auth_group,
        auth_location.name,
        channel,
        date_redeemed_date,
        location_group_dt.label
      ]
      measures: [average_Transaction_value, count, count_distinct_customers, total_customers, total_non_zero_transactions, total_price, total_visits, transaction_ratio]
      filters: [
        transaction_present.date_redeemed_date: "60 days"
      ]
    }

    materialization: {
      persist_for: "24 hours"
    }
  }
}
