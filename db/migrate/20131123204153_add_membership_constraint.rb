class AddMembershipConstraint < ActiveRecord::Migration
  def change
    add_index :memberships, [:user_id, :organization_id], :unique => true
  end
end
