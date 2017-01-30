class AddAutoSendToComment < ActiveRecord::Migration
  def change
    add_column :comments, :auto_send, :boolean, :default => false
  end
end
