class RemoveUserStuff < ActiveRecord::Migration
  def change
    remove_column :users, :is_person_in_need
    remove_column :users, :use_own_email
    remove_column :users, :is_anonymous
  end
end
