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

        creation_response = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(201)
        expect(creation_response[:success]).to eq('message created')
      end
    end

    context 'with invalid or missing params' do
      it 'does not create a Message object - missing :body' do
      end

      it 'does not create a Message object - missing :recipient' do
      end

      it 'does not create a Message object - missing :sender' do
      end

      it 'does not create a Message object - sending and illegal param' do
      end
    end

  end



end
