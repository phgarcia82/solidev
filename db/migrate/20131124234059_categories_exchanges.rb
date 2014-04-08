class CategoriesExchanges < ActiveRecord::Migration
  def change
    create_table :categories_exchanges do |t|
      t.references :category
      t.references :exchange
    end
  end
end
