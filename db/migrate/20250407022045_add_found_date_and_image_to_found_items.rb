class AddFoundDateAndImageToFoundItems < ActiveRecord::Migration[7.1]
  def change
    # remove or comment this line below (it already exists)
    # add_column :found_items, :found_date, :date

    add_column :found_items, :image, :string unless column_exists?(:found_items, :image)
  end
end