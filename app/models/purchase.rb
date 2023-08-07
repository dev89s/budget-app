class Purchase < ApplicationRecord
  belongs_to :author

  validates :name, presence: true, length: { maximum: 100 }
  validates :amount, presence: true
end
