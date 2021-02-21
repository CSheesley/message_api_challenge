require 'rails_helper'

RSpec.describe Api::V1::MessagesController, type: :request do

  describe 'POST /api/v1/messages' do

    context 'with valid parameters' do
      it 'creates a Message object' do
        valid_params = {
          recipient: 'abbey',
          sender: 'corey',
          body: 'a short message'
        }

        expect {
          post '/api/v1/messages', params: valid_params
        }.to change { Message.count }.by(1)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(201)
        expect(parsed_response[:success]).to eq('Message created')
      end
    end

    context 'with missing params' do
      it 'does not create a Message object - missing :body' do
        missing_body_params = {
          recipient: 'abbey',
          sender: 'corey'
        }

        expect {
          post '/api/v1/messages', params: missing_body_params
        }.to_not change { Message.count }

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(422)
        expect(parsed_response[:errors]).to eq("Body can't be blank")
      end

      it 'does not create a Message object - missing :recipient' do
        missing_sender_params = {
          sender: 'corey',
          body: 'a short message'
        }

        expect {
          post '/api/v1/messages', params: missing_sender_params
        }.to_not change { Message.count }

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(422)
        expect(parsed_response[:errors]).to eq("Recipient can't be blank")
      end

      it 'does not create a Message object - missing :sender' do
        missing_recipient_params = {
          recipient: 'abbey',
          body: 'a short message'
        }

        expect {
          post '/api/v1/messages', params: missing_recipient_params
        }.to_not change { Message.count }

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(422)
        expect(parsed_response[:errors]).to eq("Sender can't be blank")
      end
    end
  end
end
