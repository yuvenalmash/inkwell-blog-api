require 'rails_helper'

RSpec.describe 'Message', type: :request do
  describe 'Get /api/v1/users/:user_id/messages' do
    it 'returns all messages' do
      user = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user)
      FactoryBot.create(:message, sender: user, recipient: user2)
      FactoryBot.create(:message, sender: user2, recipient: user)
      get "/api/v1/users/#{user.id}/messages"
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'POST /api/v1/users/:user_id/messages' do
    it 'creates a message' do
      user = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user)
      message_params = { content: 'Hello', sender_id: user.id, recipient_id: user2.id }
      expect do
        post "/api/v1/users/#{user.id}/messages", params: { message: message_params }
      end.to change(Message, :count).by(1)
      expect(response).to have_http_status(201)
    end
  end

  describe 'DELETE /api/v1/users/:user_id/messages/:id' do
    it 'deletes a message' do
      user = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user)
      message = FactoryBot.create(:message, sender: user, recipient: user2)
      expect { delete "/api/v1/users/#{user.id}/messages/#{message.id}" }.to change(Message, :count).by(-1)
      expect(response).to have_http_status(204)
    end
  end
end
