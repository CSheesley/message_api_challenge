require 'rails_helper'

RSpec.describe Api::V1::MessagesController, type: :request do

  describe 'GET /api/v1/messages' do

    context 'with valid parameters' do

      it 'returns Message JSON - sent to a :recipient' do
        message1 = Message.create(recipient: 'corey', sender: 'abbey', body: Faker::Lorem.sentence)
        message2 = Message.create(recipient: 'corey', sender: 'billy', body: Faker::Lorem.sentence)

        get '/api/v1/messages', params: { recipient: 'corey' }

        parsed_response = JSON.parse(response.body)
        expected_meeting_data = {
          "messages": [
            {
              "sender": message1.sender,
              "message_id": message1.id,
              "created_at": message1.created_at,
              "body": message1.body
            },
            {
              "sender": message2.sender,
              "message_id": message2.id,
              "created_at": message2.created_at,
              "body": message2.body
            }
          ]
        }

        expect(response).to have_http_status(200)
        expect(parsed_response).to eq(expected_meeting_data)
      end

      it 'returns Message JSON - sent to a :recipient, from all senders if no :sender specified' do
        message1 = Message.create(recipient: 'corey', sender: 'abbey', body: Faker::Lorem.sentence)
        message2 = Message.create(recipient: 'corey', sender: 'billy', body: Faker::Lorem.sentence)
        message3 = Message.create(recipient: 'corey', sender: 'abbey', body: Faker::Lorem.sentence)
        # this message should not be included
        message4 = Message.create(recipient: 'abbey', sender: 'billy', body: Faker::Lorem.sentence)

        get '/api/v1/messages', params: { recipient: 'corey' }

        parsed_response = JSON.parse(response.body)
        response_msg_ids = parsed_response[:messages].map { |msg| msg[:message_id] }

        expect(response).to have_http_status(200)
        expect(parsed_response[:messages].count).to eq(3)
        expect(response_msg_ids).to match_array([ message1.id, message2.id, message3.id ])
      end

      it 'returns Message JSON - sent to a :recipient, from a specific :sender' do
        message1 = Message.create(recipient: 'corey', sender: 'abbey', body: Faker::Lorem.sentence)
        message2 = Message.create(recipient: 'corey', sender: 'billy', body: Faker::Lorem.sentence)
        message3 = Message.create(recipient: 'corey', sender: 'abbey', body: Faker::Lorem.sentence)
        message4 = Message.create(recipient: 'corey', sender: 'billy', body: Faker::Lorem.sentence)
        message5 = Message.create(recipient: 'corey', sender: 'tommy', body: Faker::Lorem.sentence)

        get '/api/v1/messages', params: { recipient: 'corey', sender: 'abbey' }

        parsed_response = JSON.parse(response.body)
        response_msg_ids = parsed_response[:messages].map { |msg| msg[:message_id] }

        expect(response).to have_http_status(200)
        expect(parsed_response[:messages].count).to eq(2)
        expect(response_msg_ids).to match_array([ message1.id, message3.id ])
      end

      it 'returns Message JSON - with maximum of 100 messages' do
      end

      it 'returns Message JSON - limited to the last 30 days, if there are more than 100 messages' do
      end

      it 'returns Message JSON - in order from newest to oldest' do
      end
    end

    context 'with missing params' do

      it 'returns an error message if missing :recipient param' do
      end
    end
  end
end
