class AddOrderGroupToOrders < ActiveRecord::Migration[8.0]
  def change
    add_reference :orders, :order_group, null: true, foreign_key: true
  end
end
