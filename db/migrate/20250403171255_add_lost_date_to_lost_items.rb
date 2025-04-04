class AddLostDateToLostItems < ActiveRecord::Migration[8.0]
  def change
    add_column :lost_items, :lost_date, :date
  end
end
