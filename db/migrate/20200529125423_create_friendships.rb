class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :sender_id, foreign_key: true
      t.integer :receiver_id, foreign_key: true
      t.boolean :status, default: false

      t.timestamps
    end
    add_index(:friendships, [:sender_id, :receiver_id], unique: true)
  end
end
