class CompleteUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :username, :string

    add_column :users, :addr_street, :string
    add_column :users, :addr_number, :string
    add_column :users, :addr_postcode, :string
    add_column :users, :addr_city, :string
    add_column :users, :phone_number, :string
    add_column :users, :id_card_number, :string
    add_column :users, :id_card_upload, :string
    add_column :users, :facebook_url, :string
    add_column :users, :is_anonymous, :boolean
    add_column :users, :use_own_email, :boolean
    add_column :users, :is_system_admin, :boolean
    add_column :users, :is_person_in_need, :boolean
    add_column :users, :status, :integer
  end
end
