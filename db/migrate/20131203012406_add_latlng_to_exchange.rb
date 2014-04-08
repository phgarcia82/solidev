class AddLatlngToExchange < ActiveRecord::Migration
  def change
    add_column :exchanges, :latlng, :string
  end
end
