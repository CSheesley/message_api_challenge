require 'rails_helper'

RSpec.describe Search::MessagesFilter, type: :service do

  describe 'filtering' do

    it 'can filter messages by :recipient' do
    end

    it 'can filter messages by :recipient and :sender' do
    end

    it 'limits the number of message results to 100' do
    end

    it 'limits message results to those :created_at in the past 30 days' do
    end

    it 'applies both the 100 message limit and :created_at filtering' do
    end
  end
end
