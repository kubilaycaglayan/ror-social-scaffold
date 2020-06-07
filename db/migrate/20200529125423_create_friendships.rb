class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :user_id, foreign_key: true
      t.integer :friend_id, foreign_key: true
      t.boolean :status, default: false

      t.timestamps
    end
    add_index(:friendships, [:user_id, :friend_id], unique: true)
  end
end
