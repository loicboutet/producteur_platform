class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :ensure_producer!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_product, only: [ :show, :edit, :update, :destroy ]

  def index
    @products = Product.includes(:producer).available.recent
  end

  def show
  end

  def new
    @product = current_user.producer.products.build
  end

  def create
    @product = current_user.producer.products.build(product_params)

    if @product.save
      redirect_to @product, notice: "Product created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    redirect_to root_path, alert: "Access denied" unless @product.producer.user == current_user
  end

  def update
    redirect_to root_path, alert: "Access denied" unless @product.producer.user == current_user

    if @product.update(product_params)
      redirect_to @product, notice: "Product updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    redirect_to root_path, alert: "Access denied" unless @product.producer.user == current_user

    @product.destroy
    redirect_to products_path, notice: "Product deleted successfully!"
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def ensure_producer!
    unless current_user.producer?
      redirect_to new_producer_path, alert: "You need to create a producer account first"
    end
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock)
  end
end
