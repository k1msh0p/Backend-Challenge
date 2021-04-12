class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.integer :member_id
      t.integer :friend_id

      t.timestamps
    end
   	add_foreign_key :friends, :members
   	add_foreign_key :friends, :members, column: :friend_id

  end
end
