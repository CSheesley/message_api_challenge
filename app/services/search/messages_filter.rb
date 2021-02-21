class Search::MessagesFilter

  def initialize(message_params)
    @recipient = message_params[:recipient]
    @sender = message_params[:sender]
  end

  def results
    scope = scope_base
    scope = apply_sender_filter(scope)
    scope = apply_last_month_filter(scope)
    scope = apply_count_limit_filter(scope)
    scope = sort_newest_to_oldest(scope)

    return scope
  end

  private

  def scope_base
    Message.where(recipient: @recipient)
  end

  def apply_sender_filter(scope)
    return scope unless @sender

    scope.where(sender: @sender)
  end

  def apply_last_month_filter(scope)
    scope.where(created_at: 29.days.ago.beginning_of_day..0.days.ago.end_of_day)
  end

  def apply_count_limit_filter(scope)
    scope.limit(100)
  end

  def sort_newest_to_oldest(scope)
    scope.order(created_at: :desc)
  end
end
