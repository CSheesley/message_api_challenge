require 'rails_helper'

RSpec.describe Api::V1::MessagesController, type: :request do

  describe 'GET /api/v1/messages' do

    context 'with valid parameters' do

      it 'returns Message JSON - sent to a :recipient' do
        message1 = Message.create(recipient: 'corey', sender: 'abbey', body: Faker::Lorem.sentence, created_at: 1.minute.ago)
        message2 = Message.create(recipient: 'corey', sender: 'billy', body: Faker::Lorem.sentence, created_at: 2.minutes.ago)

        get '/api/v1/messages', params: { recipient: 'corey' }

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expected_response = {
          "messages": [
            {
              "sender": message1.sender,
              "message_id": message1.id,
              "created_at": message1.created_at.strftime('%m-%d-%Y %H:%M:%S %Z'),
              "body": message1.body
            },
            {
              "sender": message2.sender,
              "message_id": message2.id,
              "created_at": message2.created_at.strftime('%m-%d-%Y %H:%M:%S %Z'),
              "body": message2.body
            }
          ]
        }

        expect(response).to have_http_status(200)
        expect(parsed_response).to eq(expected_response)
      end

      it 'returns Message JSON - sent to a :recipient, from all senders if no :sender is specified' do
        message1 = Message.create(recipient: 'corey', sender: 'abbey', body: Faker::Lorem.sentence)
        message2 = Message.create(recipient: 'corey', sender: 'billy', body: Faker::Lorem.sentence)
        message3 = Message.create(recipient: 'corey', sender: 'abbey', body: Faker::Lorem.sentence)
        message4 = Message.create(recipient: 'abbey', sender: 'billy', body: Faker::Lorem.sentence)

        get '/api/v1/messages', params: { recipient: 'corey' }

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        response_msg_ids = parsed_response[:messages].map { |msg| msg[:message_id] }

        expect(response).to have_http_status(200)
        expect(parsed_response[:messages].count).to eq(3)
        expect(response_msg_ids).to match_array([message1.id, message2.id, message3.id])
      end

      it 'returns Message JSON - sent to a :recipient, from a specific :sender' do
        message1 = Message.create(recipient: 'corey', sender: 'abbey', body: Faker::Lorem.sentence)
        message2 = Message.create(recipient: 'corey', sender: 'billy', body: Faker::Lorem.sentence)
        message3 = Message.create(recipient: 'corey', sender: 'abbey', body: Faker::Lorem.sentence)
        message4 = Message.create(recipient: 'corey', sender: 'billy', body: Faker::Lorem.sentence)
        message5 = Message.create(recipient: 'corey', sender: 'tommy', body: Faker::Lorem.sentence)

        get '/api/v1/messages', params: { recipient: 'corey', sender: 'abbey' }

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        response_msg_ids = parsed_response[:messages].map { |msg| msg[:message_id] }

        expect(response).to have_http_status(200)
        expect(parsed_response[:messages].count).to eq(2)
        expect(response_msg_ids).to match_array([message1.id, message3.id])
      end

      it 'returns Message JSON - limited to the last 30 days' do
        message1 = Timecop.freeze(Time.now - 0.days)  { Message.create(recipient: 'corey', sender: 'abbey', body: Faker::Lorem.sentence) }
        message2 = Timecop.freeze(Time.now - 29.days)  { Message.create(recipient: 'corey', sender: 'derek', body: Faker::Lorem.sentence) }
        message3 = Timecop.freeze(Time.now - 30.days) { Message.create(recipient: 'corey', sender: 'abbey', body: Faker::Lorem.sentence) }
        message4 = Timecop.freeze(Time.now - 99.days) { Message.create(recipient: 'corey', sender: 'derek', body: Faker::Lorem.sentence) }

        get '/api/v1/messages', params: { recipient: 'corey' }

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        response_msg_ids = parsed_response[:messages].map { |msg| msg[:message_id] }

        expect(response).to have_http_status(200)
        expect(parsed_response[:messages].count).to eq(2)
        expect(response_msg_ids).to match_array([message1.id, message2.id])
      end

      it 'returns Message JSON - with maximum of 100 messages' do
        105.times { Message.create(recipient: 'corey', sender: Faker::Name.first_name, body: Faker::Lorem.sentence) }

        get '/api/v1/messages', params: { recipient: 'corey' }

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        response_msg_ids = parsed_response[:messages].map { |msg| msg[:message_id] }

        expect(response).to have_http_status(200)
        expect(parsed_response[:messages].count).to eq(100)
      end

      it 'returns Message JSON - in order from newest to oldest' do
        message1 = Timecop.freeze(Time.now - 0.days) { Message.create(recipient: 'corey', sender: 'abbey', body: Faker::Lorem.sentence) }
        message2 = Timecop.freeze(Time.now - 2.days) { Message.create(recipient: 'corey', sender: 'billy', body: Faker::Lorem.sentence) }
        message3 = Timecop.freeze(Time.now - 3.days) { Message.create(recipient: 'corey', sender: 'derek', body: Faker::Lorem.sentence) }
        message4 = Timecop.freeze(Time.now - 1.days) { Message.create(recipient: 'corey', sender: 'bobby', body: Faker::Lorem.sentence) }

        get '/api/v1/messages', params: { recipient: 'corey' }

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        response_msg_ids = parsed_response[:messages].map { |msg| msg[:message_id] }

        expect(response).to have_http_status(200)
        expect(parsed_response[:messages].count).to eq(4)
        expect(response_msg_ids).to eq([message1.id, message4.id, message2.id, message3.id])
      end
    end

    context 'with a missing or non-existent :recipient' do

      it 'returns an error message if missing :recipient param' do
        get '/api/v1/messages', params: { }

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(422)
        expect(parsed_response[:errors]).to eq("Missing required :recipient param")
      end
    end
  end
end
