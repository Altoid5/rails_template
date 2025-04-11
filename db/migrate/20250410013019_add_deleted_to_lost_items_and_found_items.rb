class AddDeletedToLostItemsAndFoundItems < ActiveRecord::Migration[7.1]
  def change
    add_column :lost_items, :deleted, :boolean, default: false
    add_column :found_items, :deleted, :boolean, default: false
  end
end