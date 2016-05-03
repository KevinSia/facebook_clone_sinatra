class CreateFriendships < ActiveRecord::Migration
	def change
    create_table :friendships do |f|
      f.references :user, index: true, null: false
      f.integer :friend_id, index: true, null: false
    end

    add_index :friendships, [:friend_id, :user_id]
	end
end
