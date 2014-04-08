class AddCategoryIdToExchange < ActiveRecord::Migration
  def change
    add_column :exchanges, :category_id, :integer
  end
end
