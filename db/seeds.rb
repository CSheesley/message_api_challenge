# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'timecop'

## Creates 240 Message objects
## Connect to the database from the command line by running: $ rails console
## Query the database using Active Record commands such as `> Message.count`, or `>Message.first`

# A few Example Messages
Message.create(recipient: 'guild', sender: 'corey', body: 'Hi Guild, I hope you like my code!')

Message.create(recipient: 'corey', sender: 'abbey', body: Faker::Lorem.sentence)
Message.create(recipient: 'corey', sender: 'abbey', body: Faker::Lorem.sentence, created_at: 1.week.ago)
Message.create(recipient: 'corey', sender: 'billy', body: Faker::Lorem.sentence, created_at: 1.hour.ago)
Message.create(recipient: 'corey', sender: 'tommy', body: Faker::Lorem.sentence, created_at: 1.minute.ago)


# A :recipient who has received more than 100 messages - I hear Justin Bieber is pretty popular?
125.times { Message.create(recipient: 'bieber', sender: Faker::Name.first_name, body: Faker::Lorem.sentence) }


# A :recipient with a lot of messages, but only a handful of recent ones - What is Mick Jagger up to?
10.times {
  Message.create(recipient: 'jagger', sender: Faker::Name.first_name, body: Faker::Lorem.sentence)
}
100.times {
  Timecop.freeze(Time.now - 100.days) {
    Message.create(recipient: 'jagger', sender: Faker::Name.first_name, body: Faker::Lorem.sentence)
  }
}
