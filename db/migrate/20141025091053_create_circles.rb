class CreateCircles < ActiveRecord::Migration
  def change
    create_table :circles do |t|
      t.string :name
      t.integer :user_id
      t.string :organisation_id

      t.timestamps
    end
  end
end
