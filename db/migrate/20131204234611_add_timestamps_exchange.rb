class AddTimestampsExchange < ActiveRecord::Migration
  def change
    add_column(:exchanges, :created_at, :datetime)
    add_column(:exchanges, :updated_at, :datetime)
  end
end
