class Api::V1::MessagesController < ApplicationController

  def create
    message = Message.new(message_params)
    if message.save
<<<<<<< Updated upstream
      render status: 201, json: { success: 'message created' }
    else
      # render status: 422, json: { message.errors }
=======
      render status: 201, json: { success: 'Message created' }
    else
      render status: 422, json: { errors: message.errors.full_messages.join(", ") }
>>>>>>> Stashed changes
    end
  end

  private

  def message_params
    params.permit(:body, :recipient, :sender)
  end
end
