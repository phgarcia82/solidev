class CreateMessageRecipients < ActiveRecord::Migration
  def change
    create_table :message_recipients do |t|
      t.integer :mid
      t.integer :seq
      t.integer :uid
      t.string :status

      t.timestamps
    end
  end
end
