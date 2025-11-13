class CreateProducers < ActiveRecord::Migration[8.0]
  def change
    create_table :producers do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :stripe_account_id
      t.string :stripe_account_status, default: "pending"
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :producers, :stripe_account_id, unique: true
    add_index :producers, :email, unique: true
  end
end
