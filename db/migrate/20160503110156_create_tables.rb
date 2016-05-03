class CreateTables < ActiveRecord::Migration
	def change
    create_table :users do |u|
      u.string :first_name, null: false
      u.string :last_name, null: false
      u.string :email, null: false
      u.string :password, null: false
      u.timestamps null: false
    end

    create_table :statuses do |s|
      s.string :content, null: false, limit: 140
      s.references :user, index: true, null: false
      s.timestamps null: false
    end

    create_table :likes do |l|
      l.references :status, index: true, null: false
      l.references :user, index: true, null: false
      l.timestamps null: false
    end

    # index for pair uniqueness
    add_index :likes, [:status_id, :user_id], unique: true
	end
end
