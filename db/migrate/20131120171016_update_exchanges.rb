class UpdateExchanges < ActiveRecord::Migration
  def change
    add_column :exchanges, :country, :string
  end
end
