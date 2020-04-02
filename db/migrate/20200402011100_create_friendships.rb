class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :sender_id, index: true
      t.integer :receiver_id, index: true
      t.boolean :accepted

      t.timestamps
    end

  
    add_foreign_key :friendships, :users, column: :sender_id 
    add_foreign_key :friendships, :users, column: :receiver_id
  end
end
