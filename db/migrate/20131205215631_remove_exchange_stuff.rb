class RemoveExchangeStuff < ActiveRecord::Migration
  def change
    remove_column :exchanges, :country
    remove_column :exchanges, :city
  end
end
