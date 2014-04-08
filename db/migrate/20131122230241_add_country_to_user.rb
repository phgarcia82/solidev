class AddCountryToUser < ActiveRecord::Migration
  def change
    add_column :users, :country, :integer
  end
end
