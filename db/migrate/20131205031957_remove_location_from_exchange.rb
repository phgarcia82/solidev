class RemoveLocationFromExchange < ActiveRecord::Migration
  def change
    remove_column :exchanges, :location, :string
  end
end
