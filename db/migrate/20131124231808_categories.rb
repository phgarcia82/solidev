class Categories < ActiveRecord::Migration
  def change
    create_table(:categories) do |t|
      t.string :title
      t.references :category
    end
  end
end
