class AddLanguageSpokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :language_spoken, :string
  end
end
