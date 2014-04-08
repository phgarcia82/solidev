class CardUpload < ActiveRecord::Migration
  def change
    remove_column :users, :id_card_upload
    add_attachment :users, :id_card
  end
end
