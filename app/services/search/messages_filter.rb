class Search::MessagesFilter

  def initialize(message_params)
    @recipient = message_params[:recipient]
    @sender = message_params[:sender]
    @body = message_params[:body]
  end

  def results
    scope = scope_base
  end

  private

  def scope_base
    Message.where(recipient: @recipient)
  end
end
