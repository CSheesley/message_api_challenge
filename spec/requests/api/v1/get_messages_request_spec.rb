require 'rails_helper'

RSpec.describe Api::V1::MessagesController, type: :request do

  describe 'GET /api/v1/messages' do

    context 'with valid parameters' do

      it 'returns Message JSON - sent to a :recipient, from all senders' do
      end

      it 'returns Message JSON - sent to a :recipient, from a specific :sender' do
      end

      it 'returns Message JSON - with maximum of 100 messages' do
      end

      it 'returns Message JSON - limited to the last 30 days, if there are more than 100 messages' do
      end
    end

    context 'with missing params' do

      it 'returns an error message if missing :recipient param' do
      end
    end
  end

end
