class CreateCarts < ActiveRecord::Migration[8.0]
  def change
    create_table :carts do |t|
      t.references :user, foreign_key: true # Null si invité
      t.string :session_id, null: false

      t.timestamps
    end

    add_index :carts, :session_id, unique: true
  end
end
