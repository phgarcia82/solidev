class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :proposal_id
      t.integer :user_id
      t.integer :organization_id
      t.integer :person_in_need_id
      t.timestamps
    end
  end
end
