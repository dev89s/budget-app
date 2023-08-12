class Category < ApplicationRecord
  before_create { |category| category.name = category.name.split.map(&:capitalize).join(' ') }
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_and_belongs_to_many :purchases

  validates :name, presence: true, length: { maximum: 100 }, format: { with: /\A[a-zA-Z][a-zA-Z0-9_\-\W]*\z/ }
  validates :icon, presence: true
end
