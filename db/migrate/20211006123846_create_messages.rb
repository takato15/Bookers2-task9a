class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|

      t.integer :id
      t.text :text
      t.integer :room_id
      t.integer :user_id

      t.timestamps
    end
  end
end
