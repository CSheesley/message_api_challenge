class CreateMessage < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :recipient
      t.string :sender
      t.text :body

      t.timestamps
    end
  end
end
