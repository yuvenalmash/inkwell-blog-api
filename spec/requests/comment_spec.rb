require 'rails_helper'

RSpec.describe 'Comment', type: :request do
  # path = /api/v1/users/:user_id/posts/:post_id/comments
  describe 'GET /api/v1/users/:user_id/posts/:post_id/comments' do
    it 'returns all comments' do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post, user: user)
      FactoryBot.create_list(:comment, 10, user: user, post: post)
      get "/api/v1/users/#{user.id}/posts/#{post.id}/comments"
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(10)
    end
  end

  describe 'POST /api/v1/users/:user_id/posts/:post_id/comments' do
    it 'creates a comment' do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post, user: user)
      comment_params = FactoryBot.attributes_for(:comment)
      expect do
        post "/api/v1/users/#{user.id}/posts/#{post.id}/comments",
             params: { comment: comment_params }
      end.to change(Comment, :count).by(1)
      expect(response).to have_http_status(201)
    end
  end

  describe 'PUT /api/v1/users/:user_id/posts/:post_id/comments/:id' do
    it 'updates a comment' do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post, user: user)
      comment = FactoryBot.create(:comment, user: user, post: post)
      comment_params = FactoryBot.attributes_for(:comment)
      put "/api/v1/users/#{user.id}/posts/#{post.id}/comments/#{comment.id}", params: { comment: comment_params }
      expect(response).to have_http_status(205)
    end
  end

  describe 'DELETE /api/v1/users/:user_id/posts/:post_id/comments/:id' do
    it 'deletes a comment' do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post, user: user)
      comment = FactoryBot.create(:comment, user: user, post: post)
      expect do
        delete "/api/v1/users/#{user.id}/posts/#{post.id}/comments/#{comment.id}"
      end.to change(Comment, :count).by(-1)
      expect(response).to have_http_status(204)
    end
  end
end
