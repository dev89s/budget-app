require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'assiciations' do
    it 'should belong to author' do
      expect(User.reflect_on_association(:purchases).macro).to be(:has_many)
    end

    it 'should belong to author' do
      expect(User.reflect_on_association(:categories).macro).to be(:has_many)
    end
  end
  describe 'validations' do
    let(:user) { User.create(firstName: 'fName', lastName: 'lName', email: 'test@test.com', password: 'password') }

    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is invalid with null firstName' do
      user.firstName = nil
      expect(user).to_not be_valid
    end

    it 'is invalid with null lastName' do
      user.lastName = nil
      expect(user).to_not be_valid
    end

    it 'is invalid with null email' do
      user.email = nil
      expect(user).to_not be_valid
    end

    it 'is invalid with null password' do
      user.email = nil
      expect(user).to_not be_valid
    end

    it 'is invalid with firstName with more than 100 chars' do
      name = 'a' * 101
      user.firstName = name
      expect(user).to_not be_valid
    end

    it 'is invalid with lastName with more than 100 chars' do
      name = 'a' * 101
      user.lastName = name
      expect(user).to_not be_valid
    end

    it 'is invalid with firstName with less than 3 chars' do
      name = 'a' * 2
      user.firstName = name
      expect(user).to_not be_valid
    end

    it 'is invalid with lastName with less than 3 chars' do
      name = 'a' * 2
      user.lastName = name
      expect(user).to_not be_valid
    end
  end
end
