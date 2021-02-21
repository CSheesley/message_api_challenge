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
        to_corey_from_billy = Search::MessagesFilter.new({ recipient: 'corey', sender: 'billy' }).results
        to_corey_from_abbey = Search::MessagesFilter.new({ recipient: 'corey', sender: 'abbey' }).results
        to_derek_from_tommy = Search::MessagesFilter.new({ recipient: 'derek', sender: 'tommy' }).results
        to_derek_from_abbey = Search::MessagesFilter.new({ recipient: 'derek', sender: 'abbey' }).results

        expect(to_corey_from_billy).to match_array([message2, message3, message4])
        expect(to_corey_from_abbey).to match_array([message1])
        expect(to_derek_from_tommy).to match_array([message5, message8])
        expect(to_derek_from_abbey).to match_array([message6])
      end
    end

    context 'limiting to 100 results, and past 30 days' do

      it 'returns messages in order of newest :created_at to oldest' do
        message1 = Timecop.freeze(Time.now - 5.days) { Message.create(recipient: 'corey', sender: 'abbey', body: Faker::Lorem.sentence) }
        message2 = Timecop.freeze(Time.now - 0.days) { Message.create(recipient: 'corey', sender: 'billy', body: Faker::Lorem.sentence) }
        message3 = Timecop.freeze(Time.now - 7.days) { Message.create(recipient: 'corey', sender: 'derek', body: Faker::Lorem.sentence) }
        message4 = Timecop.freeze(Time.now - 3.days) { Message.create(recipient: 'corey', sender: 'abbey', body: Faker::Lorem.sentence) }

        corey_msgs = Search::MessagesFilter.new({ recipient: 'corey' }).results

        expect(corey_msgs).to eq([message2, message4, message1, message3])
      end

      it 'limits message results to those :created_at in the past 30 days' do
      end

      it 'limits the number of message results to 100' do
      end

      it 'applies both the 100 message limit and :created_at filtering' do
      end
    end
  end
end
