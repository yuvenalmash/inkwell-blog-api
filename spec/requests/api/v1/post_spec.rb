require 'swagger_helper'

RSpec.describe 'api/v1/posts', type: :request do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user: @user)
  end

  path '/api/v1/posts' do
    get('list posts') do
      tags 'Post'
      consumes 'application/json'
      response(200, 'successful') do
        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/posts' do
    post('create post') do
      tags 'Post'
      consumes 'application/json'
      parameter name: :user_id, in: :path, type: :string
      parameter name: :post, in: :body, schema: {
        type: :object,
        properties: {
          post: { type: :object, properties: {
            title: { type: :string, example: Faker::Lorem.sentence },
            content: { type: :string, example: Faker::Lorem.paragraph },
            slug: { type: :string, example: Faker::Lorem.sentence }
          } }
        },
        required: %w[post]
      }
      response(201, 'successful') do
        let(:user_id) { @user.id }
        run_test!
      end
    end

    get('list posts') do
      tags 'Post'
      consumes 'application/json'
      parameter name: :user_id, in: :path, type: :string
      response(200, 'successful') do
        let(:user_id) { FactoryBot.create(:user).id }
        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/posts/{id}' do
    get('show post') do
      tags 'Post'
      consumes 'application/json'
      parameter name: :user_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string
      response(200, 'successful') do
        let(:user_id) { @user.id }
        let(:id) { @post.id }
        run_test!
      end
    end

    put('update post') do
      tags 'Post'
      consumes 'application/json'
      parameter name: :user_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string
      parameter name: :post, in: :body, schema: {
        type: :object,
        properties: {
          post: { type: :object, properties: {
            title: { type: :string, example: Faker::Lorem.sentence },
            content: { type: :string, example: Faker::Lorem.paragraph },
            slug: { type: :string, example: Faker::Lorem.sentence }
          } }
        },
        required: %w[post]
      }
      response(205, 'successful') do
        let(:user_id) { @user.id }
        let(:id) { @post.id }
        let(:post) { { post: { title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph, slug: Faker::Lorem.sentence } } }
        run_test!
      end
    end

    delete('destroy post') do
      tags 'Post'
      consumes 'application/json'
      parameter name: :user_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string
      response(204, 'successful') do
        let(:user_id) { @user.id }
        let(:id) { @post.id }
        run_test!
      end
    end
  end
end
