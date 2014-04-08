class UpdateProposals < ActiveRecord::Migration
  def change
    drop_table :proposals
    create_table :proposals do |t|
      t.text :description
      t.integer :status_cd
      t.integer :exchange_id
      t.integer :user_id
      t.integer :organization_id
      t.integer :person_in_need_id
      t.integer :proposer_rating
      t.string :proposer_msg
      t.integer :owner_rating
      t.string :owner_msg
      t.boolean :is_visible
      t.timestamps
    end
  end
end
