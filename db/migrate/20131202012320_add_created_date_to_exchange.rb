class AddCreatedDateToExchange < ActiveRecord::Migration
  def change
    add_column :exchanges, :created_date, :timestamp
  end
end
