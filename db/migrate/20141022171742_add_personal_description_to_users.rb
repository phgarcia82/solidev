class AddPersonalDescriptionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :personal_description, :string
  end
end
