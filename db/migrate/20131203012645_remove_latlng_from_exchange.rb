class RemoveLatlngFromExchange < ActiveRecord::Migration
  def change
    remove_column :exchanges, :latlng, :string
  end
end
