class AddCreatedUserToExchange < ActiveRecord::Migration
  def change
    add_column :exchanges, :created_user, :integer
  end
end
