class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer :room_id
      t.integer :user_id
      t.string :body
      t.timestamps
    end
  end
end
