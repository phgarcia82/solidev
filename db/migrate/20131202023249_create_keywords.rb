class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :value
      t.integer :count

      t.timestamps
    end
  end
end
