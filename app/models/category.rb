class Category < ApplicationRecord
  belongs_to :author

  validates :name, presence: true, length: { maximum: 100 }
  validates :icon, presence: true
end
