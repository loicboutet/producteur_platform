class CreateOrderGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :order_groups do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :total_amount, precision: 10, scale: 2, null: false
      t.decimal :platform_fee, precision: 10, scale: 2, null: false
      t.string :status, default: "pending", null: false
      t.string :stripe_payment_intent_id

      t.timestamps
    end

    add_index :order_groups, :stripe_payment_intent_id, unique: true
    add_index :order_groups, :status
  end
end
