class AddDescriptionToClaims < ActiveRecord::Migration[8.0]
  def change
    add_column :claims, :description, :text
  end
end
