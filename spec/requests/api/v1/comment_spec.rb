require 'swagger_helper'

RSpec.describe 'Comments', type: :request do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user: @user)
    @comment = FactoryBot.create(:comment, user: @user, post: @post)
  end

  path '/api/v1/users/{user_id}/posts/{post_id}/comments' do
    get('list comments') do
      tags 'Comment'
      consumes 'application/json'
      parameter name: :user_id, in: :path, type: :string
      parameter name: :post_id, in: :path, type: :string
      response(200, 'successful') do
        let(:user_id) { @user.id }
        let(:post_id) { @post.id }
        run_test!
      end
    end

    post('create comment') do
      tags 'Comment'
      consumes 'application/json'
      parameter name: :user_id, in: :path, type: :string
      parameter name: :post_id, in: :path, type: :string
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          comment: { type: :object, properties: {
            content: { type: :string, example: Faker::Lorem.paragraph }
          } }
        },
        required: %w[comment]
      }
      response(201, 'successful') do
        let(:user_id) { @user.id }
        let(:post_id) { @post.id }
        let(:comment) { { comment: FactoryBot.attributes_for(:comment) } }
        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/posts/{post_id}/comments/{id}' do
    put('update comment') do
      tags 'Comment'
      consumes 'application/json'
      parameter name: :user_id, in: :path, type: :string
      parameter name: :post_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          comment: { type: :object, properties: {
            content: { type: :string, example: Faker::Lorem.paragraph }
          } }
        },
        required: %w[comment]
      }
      response(205, 'successful') do
        let(:user_id) { @user.id }
        let(:post_id) { @post.id }
        let(:id) { @comment.id }
        let(:comment) { { comment: FactoryBot.attributes_for(:comment) } }
        run_test!
      end
    end

    delete('delete comment') do
      tags 'Comment'
      consumes 'application/json'
      parameter name: :user_id, in: :path, type: :string
      parameter name: :post_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string
      response(204, 'successful') do
        let(:user_id) { @user.id }
        let(:post_id) { @post.id }
        let(:id) { @comment.id }
        run_test!
      end
    end
  end
end
