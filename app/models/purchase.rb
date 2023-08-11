class Purchase < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_and_belongs_to_many :categories

  validates :name, presence: true, length: { maximum: 100 }, format: { with: /\A[a-zA-Z][a-zA-Z0-9_\-\W]*\z/ }
  validates :amount, presence: true, numericality: { only_number: true }

  validate :at_least_one_checkbox

  private

  def at_least_one_checkbox
    errors.add(:base, 'You must select at least one checkbox') if category_ids.blank?
  end
end
