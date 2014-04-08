class CreateOrganizations < ActiveRecord::Migration

  def up
    create_table :organizations do |t|
      t.string :name
      t.string :email
      t.string :addr_street
      t.integer :addr_number
      t.string :addr_postcode
      t.string :addr_city
      t.string :phone_number
      t.string :org_number
      t.string :site_url
      t.string :facebook_url
      t.string :description
      t.boolean :use_own_email

      t.timestamps
    end
  end


end
