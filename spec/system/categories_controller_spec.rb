require 'rails_helper'

RSpec.describe 'Categories', type: :system do
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
    sign_in @user
  end

  describe "#index" do
    before(:each) do
      visit root_path
    end

    scenario 'should have title Category' do
      assert_text 'Category'
    end

    scenario 'should have category name' do
      assert_text @category.name
    end

    scenario 'should have total amount of 0' do
      assert_text '$0.0'
    end

    scenario 'should have new button' do
      assert_text 'New Category'
    end

    scenario 'clicking on category should go to new category page' do
      click_on 'New Category'
      assert_current_path category_path(:new)
    end

    scenario 'clicking on category should go to specific category show' do
      click_on @category.name
      assert_current_path category_path(@category)
    end

    scenario 'clicking on logout button should redirect to splash screen' do
      click_on(class: 'logout')
      assert_current_path splash_screen_index_path
      sign_in @user
    end
  end

  describe '#show' do
    before(:each) do
      visit category_path(@category)
    end

    scenario 'should have Purchase title' do
      assert_text 'Purchases'
    end

    scenario 'should have specific category name' do
      assert_text @category.name
    end

    scenario 'should have amount of 0' do
      assert_text '$0.0'
    end

    scenario 'clicking on add purchase should go to new purchase page' do
      click_on 'Add Purchase'
      assert_current_path purchase_path(:new, params: {category: @category.id})
    end
  end
end
