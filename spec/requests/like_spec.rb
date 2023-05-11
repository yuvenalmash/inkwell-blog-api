require 'rails_helper'

RSpec.describe 'Like', type: :request do
  describe 'POST /api/v1/users/:user_id/posts/:post_id/likes' do
    it 'creates a like' do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post, user: user)
      expect { post "/api/v1/users/#{user.id}/posts/#{post.id}/likes" }.to change(Like, :count).by(1)
      expect(response).to have_http_status(201)
    end
  end

  describe 'DELETE /api/v1/users/:user_id/posts/:post_id/likes/:id' do
    it 'deletes a like' do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post, user: user)
      like = FactoryBot.create(:like, user: user, likeable: post)
      expect { delete "/api/v1/users/#{user.id}/posts/#{post.id}/likes/#{like.id}" }.to change(Like, :count).by(-1)
      expect(response).to have_http_status(204)
    end
  end
end
