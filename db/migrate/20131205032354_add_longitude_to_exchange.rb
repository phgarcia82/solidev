class AddLongitudeToExchange < ActiveRecord::Migration
  def change
    add_column :exchanges, :longitude, :float
  end
end
