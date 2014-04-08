class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.text :description
      t.integer :status_cd
      t.integer :exchange_id
      t.integer :user_id
      t.integer :organization_id
      t.integer :person_in_need_id
      t.boolean :is_visible
      t.timestamps
    end
  end
end
