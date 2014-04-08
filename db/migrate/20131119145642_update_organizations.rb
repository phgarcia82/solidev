class UpdateOrganizations < ActiveRecord::Migration
  def change
    remove_column :organizations, :addr_number
    remove_column :users, :addr_number
    rename_column :organizations, :org_number, :vat_number
  end
end
