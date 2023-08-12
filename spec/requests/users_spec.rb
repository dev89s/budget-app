require 'rails_helper'

RSpec.describe User, type: :request do
  let(:user) { User.new(firstName: 'Sasan', lastName: 'Moshir', email: 'email@gmail.com', password: '123123') }


  def authenticate_user(user)
    post user_session_path, params: { user: { email: user.email, password: user.password } }
    follow_redirect!
  end

  describe 'Get new user session' do
    it 'renders login page' do
      get new_user_session_path
      expect(response).to be_successful
    end
  end

  describe 'Get new user registeration' do
    it 'renders sign up page' do
      get new_user_registration_path
      expect(response).to be_successful
    end
  end

  describe 'Get new user password' do
    it 'renders pass reset page' do
      get new_user_password_path
      expect(response).to be_successful
    end
  end

  describe 'Destroy user session' do
    it 'renders signs out user and redirects to splash_screen' do
      user.save
      authenticate_user(user)
      delete destroy_user_session_path
      follow_redirect!
      expect(response).to redirect_to splash_screen_index_path
    end
  end
end
