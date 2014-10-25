class CreateCirclesMembers < ActiveRecord::Migration
  def change
    create_table :circles_members do |t|
      t.integer :circle_id
      t.integer :user_id

      t.timestamps
    end
  end
end
