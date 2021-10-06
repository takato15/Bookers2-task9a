class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|

      t.integer :id
      t.integer :user_id
      t.integer :second_user_id

      t.timestamps
    end
  end
end
