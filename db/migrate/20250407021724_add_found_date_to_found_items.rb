class AddFoundDateToFoundItems < ActiveRecord::Migration[8.0]
  def change
    add_column :found_items, :found_date, :date
  end
end
