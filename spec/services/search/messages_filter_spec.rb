require 'rails_helper'

RSpec.describe Search::MessagesFilter, type: :service do

  describe 'filtering' do

    context ':recipient and :sender' do
      let!(:message1) { Message.create(recipient: 'corey', sender: 'abbey', body: Faker::Lorem.sentence) }
      let!(:message2) { Message.create(recipient: 'corey', sender: 'billy', body: Faker::Lorem.sentence) }
      let!(:message3) { Message.create(recipient: 'corey', sender: 'billy', body: Faker::Lorem.sentence) }
      let!(:message4) { Message.create(recipient: 'corey', sender: 'billy', body: Faker::Lorem.sentence) }
      let!(:message5) { Message.create(recipient: 'derek', sender: 'tommy', body: Faker::Lorem.sentence) }
      let!(:message6) { Message.create(recipient: 'derek', sender: 'abbey', body: Faker::Lorem.sentence) }
      let!(:message7) { Message.create(recipient: 'derek', sender: 'corey', body: Faker::Lorem.sentence) }
      let!(:message8) { Message.create(recipient: 'derek', sender: 'tommy', body: Faker::Lorem.sentence) }

      it 'can filter messages by :recipient' do
        corey_msgs = Search::MessagesFilter.new({ recipient: 'corey' }).results
        derek_msgs = Search::MessagesFilter.new({ recipient: 'derek' }).results

        expect(corey_msgs).to match_array([message1, message2, message3, message4])
        expect(derek_msgs).to match_array([message5, message6, message7, message8])
      end

      it 'can filter messages by :recipient and :sender' do
      end
    end

    it 'limits the number of message results to 100' do
    end

    it 'limits message results to those :created_at in the past 30 days' do
    end

    it 'applies both the 100 message limit and :created_at filtering' do
    end
  end
end
