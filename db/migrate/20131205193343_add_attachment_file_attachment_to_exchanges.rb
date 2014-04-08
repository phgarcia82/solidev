class AddAttachmentFileAttachmentToExchanges < ActiveRecord::Migration
  def self.up
    change_table :exchanges do |t|
      t.attachment :file_attachment
    end
  end

  def self.down
    drop_attached_file :exchanges, :file_attachment
  end
end
