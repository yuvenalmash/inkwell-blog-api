require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do
  path '/api/v1/signup' do
    post('create user') do
      tags 'User'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: { type: :object, properties: {
            username: { type: :string, example: Faker::Internet.username },
            email: { type: :string, example: Faker::Internet.email },
            password: { type: :string, example: '123456' },
            password_confirmation: { type: :string, example: '123456' }
          }}
        },
        required: %w[user]
      }
      response(201, 'successful') do
        let(:user) { { user: FactoryBot.attributes_for(:user) } }
        run_test!
        end
      end
    end

  path '/api/v1/login' do
    post('login user') do
      tags 'User'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: { type: :object, properties: {
            email: { type: :string, example: Faker::Internet.email },
            password: { type: :string, example: '123456' }
          }}
        },
        required: %w[user]
      }
      response(200, 'successful') do
        user = FactoryBot.create(:user)
        let(:user) { { user: { email: user.email, password: user.password } } }
        run_test!
      end
    end
  end

  path '/api/v1/users' do
    get('list users') do
      tags 'User'
      consumes 'application/json'
      response(200, 'successful') do
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do
    get('show user') do
      tags 'User'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      response(200, 'successful') do
        let(:id) { FactoryBot.create(:user).id }
        run_test!
      end
    end

    patch('update user') do
      tags 'User'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: { type: :object, properties: {
            username: { type: :string, example: Faker::Internet.username },
            email: { type: :string, example: Faker::Internet.email },
            password: { type: :string, example: '123456' },
            password_confirmation: { type: :string, example: '123456' }
          }}
        },
        required: %w[user]
      }

      response(205, 'successful') do
        user = FactoryBot.create(:user)
        let(:id) { user.id }
        let(:user) { { user: { username: user.username, email: user.email } } }
        # let('Authorization') { 'Bearer #{user.generate_jwt}' }
        run_test!
      end
    end
  end
end
