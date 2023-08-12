require 'rails_helper'

RSpec.describe '/purchases', type: :request do

  let(:user) { User.new(firstName: 'Sasan', lastName: 'Moshir', email: 'email@gmail.com', password: '123123') }
  let(:category) { Category.new(name: 'Cat1', icon: 'https://cdn-icons-png.flaticon.com/512/223/223117.png', author_id: user.id) }
  let(:purchase) { Purchase.new(name: 'Pur1', amount: 12, author_id: user.id, category_ids: [category.id]) }

  before do
    user.save
    authenticate_user(user)
    category.save
    purchase.save
  end

  def authenticate_user(user)
    post user_session_path, params: { user: { email: user.email, password: user.password } }
    follow_redirect!
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get purchases_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get purchase_url(purchase)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_purchase_url
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Purchase' do
        expect do
          post purchases_url, params: { purchase: {name: 'Pur2', amount: 15, author_id: user.id, category_ids: [category.id]} }
        end.to change(Purchase, :count).by(1)
      end

      it 'redirects to the created purchase' do
        post purchases_url, params: { purchase: {name: 'Pur2', amount: 15, author_id: user.id, category_ids: [category.id]} }
        expect(response).to redirect_to(category_url(category))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Purchase' do
        expect do
          post purchases_url, params: { purchase: {name: '1Pur2', amount: 15, author_id: user.id, category_ids: [category.id]} }
        end.to change(Purchase, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post purchases_url, params: { purchase: {name: '1Pur2', amount: 15, author_id: user.id, category_ids: [category.id]} }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested purchase' do
      purchase = Purchase.create! name: 'Pur2', amount: 15, author_id: user.id, category_ids: [category.id]
      expect do
        delete purchase_url(purchase)
      end.to change(Purchase, :count).by(-1)
    end

    it 'redirects to the category_url list' do
      purchase = Purchase.create! name: 'Pur2', amount: 15, author_id: user.id, category_ids: [category.id]
      delete purchase_url(purchase)
      expect(response).to redirect_to(category_url(category))
    end
  end
end
