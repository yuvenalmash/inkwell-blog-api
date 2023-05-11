require 'rails_helper'

RSpec.describe 'Post', type: :request do
  describe 'GET /api/v1/posts' do
    it 'returns all posts' do
      FactoryBot.create_list(:post, 10)
      get '/api/v1/posts'
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(10)
    end
  end

  describe 'GET /api/v1/posts/:id' do
    it 'returns a post' do
      post = FactoryBot.create(:post)
      get "/api/v1/posts/#{post.id}"
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['id']).to eq(post.id)
    end
  end

  describe 'POST /api/v1/users/:user_id/posts' do
    it 'creates a post' do
      user = FactoryBot.create(:user)
      post_params = FactoryBot.attributes_for(:post)
      expect { post "/api/v1/users/#{user.id}/posts", params: { post: post_params } }.to change(Post, :count).by(1)
      expect(response).to have_http_status(201)
    end
  end

  describe 'PUT /api/v1/users/:user_id/posts/:id' do
    it 'updates a post' do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post, user: user)
      post_params = FactoryBot.attributes_for(:post)
      put "/api/v1/users/#{user.id}/posts/#{post.id}", params: { post: post_params }
      expect(response).to have_http_status(205)
    end
  end

  describe 'DELETE /api/v1/users/:user_id/posts/:id' do
    it 'deletes a post' do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post, user: user)
      expect { delete "/api/v1/users/#{user.id}/posts/#{post.id}" }.to change(Post, :count).by(-1)
      expect(response).to have_http_status(204)
    end
  end
end
