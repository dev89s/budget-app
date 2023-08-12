require 'rails_helper'

RSpec.describe '/categories', type: :request do
  let(:user) { User.new(firstName: 'Sasan', lastName: 'Moshir', email: 'email@gmail.com', password: '123123') }
  let(:category) { Category.new(name: 'Cat1', icon: 'https://cdn-icons-png.flaticon.com/512/223/223117.png', author_id: user.id) }

  before do
    user.save
    authenticate_user(user)
    category.save
  end

  def authenticate_user(user)
    post user_session_path, params: { user: { email: user.email, password: user.password } }
    follow_redirect!
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get categories_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get category_url(category)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_category_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      get edit_category_url(category)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Category' do
        expect do
          post categories_url, params: { category: { name: 'Cat2', icon: 'https://cdn-icons-png.flaticon.com/512/223/223117.png', author_id: user.id } }
        end.to change(Category, :count).by(1)
      end

      it 'redirects to the created category' do
        post categories_url, params: { category: { name: 'Cat2', icon: 'https://cdn-icons-png.flaticon.com/512/223/223117.png', author_id: user.id } }
        expect(response).to redirect_to(categories_url)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Category' do
        expect do
          post categories_url, params: { category: { name: '1Cat2', icon: 'https://cdn-icons-png.flaticon.com/512/223/223117.png', author_id: user.id } }
        end.to change(Category, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post categories_url, params: { category: { name: '1Cat2', icon: 'https://cdn-icons-png.flaticon.com/512/223/223117.png', author_id: user.id } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested category' do
      category = Category.create! name: 'Cat2', icon: 'https://cdn-icons-png.flaticon.com/512/223/223117.png',
                                  author_id: user.id
      expect do
        delete category_url(category)
      end.to change(Category, :count).by(-1)
    end

    it 'redirects to the categories list' do
      category = Category.create! name: 'Cat2', icon: 'https://cdn-icons-png.flaticon.com/512/223/223117.png',
                                  author_id: user.id
      delete category_url(category)
      expect(response).to redirect_to(categories_url)
    end
  end
end
