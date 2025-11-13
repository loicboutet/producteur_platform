class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :producer, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :order_groups, dependent: :destroy
  has_one :cart, dependent: :destroy

  # Check if user is a producer
  def producer?
    producer.present?
  end

  # Check if user can sell (has active Stripe account)
  def can_sell?
    producer? && producer.can_receive_payments?
  end
end
