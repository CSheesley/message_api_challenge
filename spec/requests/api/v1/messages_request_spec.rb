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

<<<<<<< Updated upstream
        creation_response = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(201)
        expect(creation_response[:success]).to eq('message created')
=======
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(201)
        expect(parsed_response[:success]).to eq('Message created')
>>>>>>> Stashed changes
      end
    end

    context 'with invalid or missing params' do
      it 'does not create a Message object - missing :body' do
<<<<<<< Updated upstream
      end

      it 'does not create a Message object - missing :recipient' do
      end

      it 'does not create a Message object - missing :sender' do
      end

      it 'does not create a Message object - sending and illegal param' do
      end
=======
        missing_body_params = {
          recipient: 'abbey',
          sender: 'corey'
        }

        expect {
          post '/api/v1/messages', params: missing_body_params
        }.to_not change { Message.count }

        creation_response = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(422)
        expect(creation_response[:errors]).to eq("Body can't be blank")
      end

      it 'does not create a Message object - missing :recipient' do
        missing_body_params = {
          body: 'a short message',
          sender: 'corey'
        }

        expect {
          post '/api/v1/messages', params: missing_body_params
        }.to_not change { Message.count }

        creation_response = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(422)
        expect(creation_response[:errors]).to eq("Recipient can't be blank")
      end

      it 'does not create a Message object - missing :sender' do
        missing_body_params = {
          body: 'a short message',
          recipient: 'abbey',
        }

        expect {
          post '/api/v1/messages', params: missing_body_params
        }.to_not change { Message.count }

        creation_response = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(422)
        expect(creation_response[:errors]).to eq("Sender can't be blank")
      end

      # it 'does not create a Message object - sending and illegal param' do
      #   missing_body_params = {
      #     body: 'a short message',
      #     sender: 'corey',
      #     recipient: 2,
      #   }
      #
      #   expect {
      #     post '/api/v1/messages', params: missing_body_params
      #   }.to_not change { Message.count }
      #
      #   creation_response = JSON.parse(response.body, symbolize_names: true)
      #
      #   expect(response.status).to eq(422)
      #   expect(creation_response[:errors]).to eq("Sender can't be blank")
      # end
>>>>>>> Stashed changes
    end

  end



end
