view: gdpr_deletion_requests {
  derived_table: {
    sql: select count(requested_at),
        date_trunc('day', requested_at) requested_day
      from zap_userdata_userdataaction
      where action_type = 'delete'
        and requested_at < current_date
      group by requested_day
      order by requested_day desc
       ;;
  }

  dimension: count {
    type: number
    sql: ${TABLE}.count ;;
  }

  dimension_group: requested_day {
    type: time
    sql: ${TABLE}.requested_day ;;
  }

  set: detail {
    fields: [count, requested_day_time]
  }
}
