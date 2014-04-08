class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :organization
      t.references :user
      t.boolean :founder
      t.boolean :admin
    end
  end
end
