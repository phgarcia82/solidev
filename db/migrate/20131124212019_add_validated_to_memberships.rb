class AddValidatedToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :validated, :boolean
  end
end
