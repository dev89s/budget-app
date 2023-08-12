require 'rails_helper'

RSpec.describe 'SplashScreens', type: :request do
  describe 'GET /index' do
    it 'renders a successful response' do
      get splash_screen_index_path
      expect(response).to be_successful
    end
  end
end
