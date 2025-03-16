class CreateFoundItems < ActiveRecord::Migration[8.0]
  def change
    create_table :found_items do |t|
      t.string :name
      t.text :description
      t.string :location
      t.string :category
      t.references :user, null: false, foreign_key: true
      t.boolean :claimed
      t.boolean :reported

      t.timestamps
    end
  end
end
