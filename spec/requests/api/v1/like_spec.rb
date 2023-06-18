require 'swagger_helper'

RSpec.describe 'Likes', type: :request do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user: @user)
  end

  path '/api/v1/users/{user_id}/posts/{post_id}/likes' do
    get('list likes') do
      tags 'Like'
      consumes 'application/json'
      parameter name: :user_id, in: :path, type: :string
      parameter name: :post_id, in: :path, type: :string
      response(200, 'successful') do
        let(:user_id) { @user.id }
        let(:post_id) { @post.id }
        run_test!
      end
    end

    post('create like') do
      tags 'Like'
      consumes 'application/json'
      parameter name: :user_id, in: :path, type: :string
      parameter name: :post_id, in: :path, type: :string
      response(201, 'successful') do
        let(:user_id) { @user.id }
        let(:post_id) { @post.id }
        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/posts/{post_id}/likes/{id}' do
    delete('destroy like') do
      tags 'Like'
      consumes 'application/json'
      parameter name: :user_id, in: :path, type: :string
      parameter name: :post_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string
      response(204, 'successful') do
        let(:user_id) { @user.id }
        let(:post_id) { @post.id }
        let(:id) { FactoryBot.create(:like, user: @user, likeable: @post).id }
        run_test!
      end
    end
  end
end
