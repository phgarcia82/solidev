class SwitchFromStringToText < ActiveRecord::Migration
  def change
    change_column :organizations, :description, :text
    change_column :exchanges, :description, :text
  end
end
