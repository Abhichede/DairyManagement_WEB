class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :customer_payments
  has_many :daily_collections
  has_many :customers

  after_create :assign_default_role

  def assign_default_role
    self.add_role(:moderator) if self.roles.blank?
  end
end
