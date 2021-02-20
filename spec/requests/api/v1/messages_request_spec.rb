require 'rails_helper'

RSpec.describe Api::V1::MessagesController, type: :request do

  describe 'POST /api/v1/messages' do

    context 'with valid parameters' do
      it 'creates a Message object' do
        valid_params = {
          body: 'a short message',
          recipient: 'abbey',
          sender: 'corey'
        }

        expect {
          post '/api/v1/messages', params: valid_params
        }.to change { Message.count }.by(1)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(201)
        expect(parsed_response[:success]).to eq('Message created')
      end
    end

    context 'with invalid or missing params' do
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
        missing_body_params = {
          body: 'a short message',
          sender: 'corey'
        }

        expect {
          post '/api/v1/messages', params: missing_body_params
        }.to_not change { Message.count }

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(422)
        expect(parsed_response[:errors]).to eq("Recipient can't be blank")
      end

      it 'does not create a Message object - missing :sender' do
        missing_body_params = {
          body: 'a short message',
          recipient: 'abbey',
        }

        expect {
          post '/api/v1/messages', params: missing_body_params
        }.to_not change { Message.count }

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(422)
        expect(parsed_response[:errors]).to eq("Sender can't be blank")
      end
    end
  end
end
