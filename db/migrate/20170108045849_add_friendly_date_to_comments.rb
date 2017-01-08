class AddFriendlyDateToComments < ActiveRecord::Migration
  def change
    add_column :comments, :friendly_date, :string
  end
end
