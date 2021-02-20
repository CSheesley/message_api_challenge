class Api::V1::MessagesController < ApplicationController

  def create
    message = Message.new(message_params)
    if message.save
      render status: 201, json: { success: 'message created' }
    else
      # render status: 422, json: { message.errors }
    end
  end

  private

  def message_params
    params.permit(:body, :recipient, :sender)
  end
end
