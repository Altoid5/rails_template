class CreateReports < ActiveRecord::Migration[8.0]
  def change
    create_table :reports do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :post_id
      t.string :post_type
      t.string :reason

      t.timestamps
    end
  end
end
