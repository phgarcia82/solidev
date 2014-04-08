class AddLatitudeToExchange < ActiveRecord::Migration
  def change
    add_column :exchanges, :latitude, :float
  end
end
