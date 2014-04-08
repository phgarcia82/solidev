class CreateExchanges < ActiveRecord::Migration
  def change
    create_table :exchanges do |t|
      t.boolean :is_offer
      t.boolean :is_demand
      t.string :title
      t.integer :quantity
      t.string :description
      t.date :start
      t.date :end
      t.integer :status_cd
      t.string :city
      t.integer :radius
      t.references :user
      t.references :organization
      t.integer :person_in_need_id
    end
    add_attachment :exchanges, :picture
  end
end
