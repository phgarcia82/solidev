class CreateSavedSearches < ActiveRecord::Migration
  def change
    create_table :saved_searches do |t|
      t.string :title
      t.text :explanation
      t.integer :organisation
      t.integer :user
      t.integer :city
      t.float :city_radius
      t.integer :category
      t.integer :type
      t.integer :frequency
      t.date :start
      t.date :end

      t.timestamps
    end
  end
end
