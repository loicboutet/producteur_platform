class ProducersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_producer, only: [ :show ]
  before_action :set_current_user_producer, only: [ :dashboard, :stripe_dashboard ]

  def new
    redirect_to producer_dashboard_path if current_user.producer?

    @producer = Producer.new
  end

  def create
    @producer = current_user.build_producer(producer_params)

    if @producer.save
      begin
        # Create Stripe Connect account
        StripeConnectService.create_account(@producer)

        # Generate onboarding link
        account_link = StripeConnectService.create_account_link(
          @producer,
          refresh_url: new_producer_url,
          return_url: onboarding_complete_producers_url
        )

        redirect_to account_link.url, allow_other_host: true
      rescue Stripe::StripeError => e
        @producer.destroy
        flash.now[:alert] = "Failed to create Stripe account: #{e.message}"
        render :new, status: :unprocessable_entity
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @products = @producer.products.recent
  end

  def dashboard
    # @producer est déjà set par set_current_user_producer
    @products = @producer.products.recent.limit(5)
    @orders = @producer.orders.recent.limit(10)
    @total_revenue = @producer.orders.paid.sum(:producer_amount)
  end

  def onboarding_refresh
    if current_user.producer?
      account_link = StripeConnectService.create_account_link(
        current_user.producer,
        refresh_url: new_producer_url,
        return_url: onboarding_complete_producers_url
      )
      redirect_to account_link.url, allow_other_host: true
    else
      redirect_to new_producer_path, alert: "Please create a producer account first"
    end
  rescue Stripe::StripeError => e
    redirect_to new_producer_path, alert: "Failed to create onboarding link: #{e.message}"
  end

  def onboarding_complete
    if current_user.producer?
      StripeConnectService.update_account_status(current_user.producer)
      redirect_to producer_dashboard_path, notice: "Your Stripe account has been set up!"
    else
      redirect_to new_producer_path, alert: "Producer account not found"
    end
  end

  def stripe_dashboard
    # @producer est déjà set par set_current_user_producer
    login_link = StripeConnectService.create_login_link(@producer)
    redirect_to login_link.url, allow_other_host: true
  rescue Stripe::StripeError => e
    redirect_to producer_dashboard_path, alert: "Failed to access Stripe dashboard: #{e.message}"
  end

  private

  def set_producer
    @producer = Producer.find(params[:id])
  end

  def set_current_user_producer
    @producer = current_user.producer
    redirect_to new_producer_path, alert: "You need to create a producer account first" unless @producer
  end

  def producer_params
    params.require(:producer).permit(:name, :email)
  end
end
