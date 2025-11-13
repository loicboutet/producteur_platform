class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :producer, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.decimal :total_amount, precision: 10, scale: 2, null: false
      t.decimal :platform_fee, precision: 10, scale: 2, null: false
      t.decimal :producer_amount, precision: 10, scale: 2, null: false
      t.string :status, default: "pending", null: false
      t.string :stripe_payment_intent_id

      t.timestamps
    end

    add_index :orders, :stripe_payment_intent_id, unique: true
    add_index :orders, :status
  end
end
