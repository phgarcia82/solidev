class ChangeStructureOfOrganisationTable < ActiveRecord::Migration
  def self.up
    # remove unused columns
    remove_column :organizations, :email
    # change column names
    rename_column :organizations, :name, :organisation_name
    # add column
    add_column :organizations, :organisation_description, :string
  end

  def self.down

  end
end
