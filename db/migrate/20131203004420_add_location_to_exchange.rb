class AddLocationToExchange < ActiveRecord::Migration
  def change
    add_column :exchanges, :location, :string
  end
end
