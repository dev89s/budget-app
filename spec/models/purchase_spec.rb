require 'rails_helper'

RSpec.describe Purchase, type: :model do
  describe 'assiciations' do
    it 'should belong to author' do
      expect(Purchase.reflect_on_association(:author).macro).to be(:belongs_to)
    end

    it 'should belong to author' do
      expect(Purchase.reflect_on_association(:categories).macro).to be(:has_and_belongs_to_many)
    end
  end

  describe 'validations' do
    let(:author) { User.create(firstName: 'fName', lastName: 'lName', email: 'test@test.com', password: 'password') }
    let(:purchase) { Purchase.create(name: 'foods', amount: 12, author:) }

    it 'is valid with valid attributes' do
      expect(purchase).to be_valid
    end

    it 'is invalid with null name' do
      purchase.name = nil
      expect(purchase).to_not be_valid
    end

    it 'is invalid with null amount' do
      purchase.amount = nil
      expect(purchase).to_not be_valid
    end

    it 'is invalid with name with more than 100 chars' do
      name = 'a' * 101
      purchase.name = name
      expect(purchase).to_not be_valid
    end

    it 'is invalid with null author_id' do
      purchase.author_id = nil
      expect(purchase).to_not be_valid
    end
  end
end
