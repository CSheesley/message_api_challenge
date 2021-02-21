class Api::V1::MessagesController < ApplicationController

  def index
    messages = Search::MessagesFilter.new(message_params)
    render status: 200, json: MessagesSerializer.new(messages).formatted_data
  end

  def create
    message = Message.new(message_params)
    message.save ? success_response : error_response(message)
  end

  private

  def success_response
    render status: 201, json: { success: 'Message created' }
  end

  def error_response(message)
    render status: 422, json: { errors: message.errors.full_messages.join(", ") }
  end

  def message_params
    params.permit(:body, :recipient, :sender)
  end
end
