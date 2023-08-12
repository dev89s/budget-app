class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_create { |user| user.firstName = user.firstName.split.map(&:capitalize).join(' ') }
  before_create { |user| user.lastName = user.lastName.split.map(&:capitalize).join(' ') }
  has_many :purchases
  has_many :categories
  validates :firstName, presence: true, length: { minimum: 3, maximum: 100 },
                        format: { with: /\A[a-zA-Z][a-zA-Z\W]*\z/ }
  validates :lastName, presence: true, length: { minimum: 3, maximum: 100 }, format: { with: /\A[a-zA-Z][a-zA-Z\W]*\z/ }
end
