class AddCodeSentAtToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :code_sent_at, :datetime
  end
end
