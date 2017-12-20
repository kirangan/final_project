class User < ApplicationRecord
  has_secure_password

  has_many :orders

  validates :username, :email, presence: true, uniqueness: true
  validates :email, format: {
    with: /.+@.+\..+/i,
    message: 'must be in valid email format'
  }
  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 8 }, allow_blank: true
  validates :gopay, numericality: { greater_than_or_equal_to: 0.0 }

  def self.update_gopay_from_order(order)
    User.find(order.user_id).update(gopay: order.reduce_gopay)
  end
end
