class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :sender_id, foreign_key: true
      t.integer :receiver_id, foreign_key: true
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
