require 'rails_helper'

RSpec.describe 'Follow', type: :request do
  describe 'GET /api/v1/users/:user_id/follows' do
    it 'returns all follows' do
      user = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user)
      user3 = FactoryBot.create(:user)
      FactoryBot.create(:follow, follower: user, followed: user2)
      FactoryBot.create(:follow, follower: user, followed: user3)
      get "/api/v1/users/#{user.id}/follows"
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'POST /api/v1/users/:user_id/follows' do
    it 'creates a follow' do
      user = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user)
      expect do
        post "/api/v1/users/#{user.id}/follows", params: { followed_id: user2.id }
      end.to change(Follow, :count).by(1)
    end
  end

  describe 'DELETE /api/v1/users/:user_id/follows/:id' do
    it 'deletes a follow' do
      user = FactoryBot.create(:user)
      follow = FactoryBot.create(:follow, follower: user)
      expect { delete "/api/v1/users/#{user.id}/follows/#{follow.id}" }.to change(Follow, :count).by(-1)
      expect(response).to have_http_status(204)
    end
  end
end
