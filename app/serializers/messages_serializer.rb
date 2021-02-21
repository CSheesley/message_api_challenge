class MessagesSerializer

  def initialize(messages)
    @messages = messages
  end

  def serialized_hash
    message_array = @messages.map do |msg|
      {
        sender: msg.sender,
        message_id: msg.id,
        created_at: msg.created_at.strftime('%m-%d-%Y %H:%M:%S %Z'),
        body: msg.body
      }
    end

    { messages: message_array }
  end

end
