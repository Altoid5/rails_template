class CreateClaims < ActiveRecord::Migration[8.0]
  def change
    create_table :claims do |t|
      t.references :user, null: false, foreign_key: true
      t.references :found_item, null: false, foreign_key: true
      t.boolean :proof_provided
      t.string :status

      t.timestamps
    end
  end
end
