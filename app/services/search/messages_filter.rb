class Search::MessagesFilter

  def initialize(message_params)
    @recipient = message_params[:recipient]
    @sender = message_params[:sender]
    @body = message_params[:body]
  end

  def results
    scope = scope_base
    scope = apply_sender_filter(scope)
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

  def sort_newest_to_oldest(scope)
    scope.order(created_at: :desc)
  end
end
