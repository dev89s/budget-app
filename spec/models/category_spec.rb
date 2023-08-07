require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'assiciations' do
    it 'should belong to author' do
      expect(Purchase.reflect_on_association(:author).macro).to be(:belongs_to)
    end

    it 'should belong to author' do
      expect(Category.reflect_on_association(:purchases).macro).to be(:has_and_belongs_to_many)
    end
  end

  describe 'validations' do
    let(:author) { User.create(firstName: 'fName', lastName: 'lName', email: 'test@test.com', password: 'password') }
    let(:category) { Category.create(name: 'foods', icon: 'icon address as string', author: author) }

    it 'is valid with valid attributes' do
      expect(category).to be_valid
    end

    it 'is invalid with null name' do
      category.name = nil
      expect(category).to_not be_valid
    end

    it 'is invalid with null amount' do
      category.icon = nil
      expect(category).to_not be_valid
    end

    it 'is invalid with name with more than 100 chars' do
      name = 'a' * 101
      category.name = name
      expect(category).to_not be_valid
    end

    it 'is invalid with null author_id' do
      category.author_id = nil
      expect(category).to_not be_valid
    end
  end
end
