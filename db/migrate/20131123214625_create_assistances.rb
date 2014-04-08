class CreateAssistances < ActiveRecord::Migration
  def change
    create_table :assistances do |t|
      t.references :organization
      t.references :user
      t.timestamps
    end
  end
end
