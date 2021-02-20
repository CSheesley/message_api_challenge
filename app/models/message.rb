class Message < ApplicationRecord
  validates_presence_of :body
  validates_presence_of :recipient
  validates_presence_of :sender

end
