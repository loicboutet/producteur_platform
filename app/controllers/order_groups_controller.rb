class OrderGroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @order_groups = current_user.order_groups.recent.includes(orders: [ :product, :producer ])
  end

  def show
    @order_group = current_user.order_groups.find(params[:id])
    @orders_by_producer = @order_group.orders.includes(:product, :producer).group_by(&:producer)
  end
end
