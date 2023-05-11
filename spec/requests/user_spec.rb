require 'rails_helper'

RSpec.describe 'User', type: :request do
  describe 'GET /api/v1/users' do
    it 'returns all users' do
      FactoryBot.create_list(:user, 10)
      get '/api/v1/users'
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(10)
    end
  end

  describe 'GET /api/v1/users/:id' do
    it 'returns a user' do
      user = FactoryBot.create(:user)
      get "/api/v1/users/#{user.id}"
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['id']).to eq(user.id)
    end
  end

  describe 'POST /api/v1/users' do
    it 'creates a user' do
      user_params = FactoryBot.attributes_for(:user)
      expect { post '/api/v1/users', params: { user: user_params } }.to change(User, :count).by(1)
      expect(response).to have_http_status(201)
    end
  end

  describe 'PUT /api/v1/users/:id' do
    it 'updates a user' do
      user = FactoryBot.create(:user)
      user_params = FactoryBot.attributes_for(:user)
      put "/api/v1/users/#{user.id}", params: { user: user_params }
      expect(response).to have_http_status(205)
    end
  end

  describe 'DELETE /api/v1/users/:id' do
    it 'deletes a user' do
      user = FactoryBot.create(:user)
      expect { delete "/api/v1/users/#{user.id}" }.to change(User, :count).by(-1)
      expect(response).to have_http_status(204)
    end
  end
end
