require 'rails_helper'

RSpec.describe 'Purchases', type: :system do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user = User.create(
      firstName: 'Sasan',
      lastName: 'Moshir',
      email: 'user@example.com',
      password: 'password',
    )
    @category = Category.create(
      name: 'Cat1',
      icon: 'https://cdn-icons-png.flaticon.com/512/223/223117.png',
      author_id: @user.id
    )
    @purchase = Purchase.create(
      name: 'Pur1',
      amount: 15,
      author_id: @user.id,
      category_ids: [@category.id]
    )
    sign_in @user
  end

  describe 'category#show' do
    before(:each) do
      visit category_path(@category)
    end

    scenario 'should have the purchases name' do
      assert_text @purchase.name
    end

    scenario 'should have the purchases amount' do
      assert_text @purchase.amount
    end

    scenario 'clicking on delete should remove purchase' do
      click_on(class: 'delete-btn')
      assert_no_text @purchase.name
      assert_no_text @purchase.amount
    end
  end

  describe 'purchase#new' do
    before(:each) do
      visit purchase_path(:new)
    end

    scenario 'should have the new Purchase title' do
      assert_text 'New Purchase'
    end

    scenario 'should have the new Purchase title' do
      assert_text 'Categories:'
    end

    scenario 'should have the new Purchase title' do
      assert_text @category.name
    end

    scenario 'should have the create purchase button' do
      expect(find(class: 'new-pur-submit').value).to eq("Create Purchase")
    end
  end
end
