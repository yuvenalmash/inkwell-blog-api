require 'rails_helper'

RSpec.describe 'Message', type: :model do
  describe 'associations' do
    it 'belongs to a sender' do
      expect(Message.reflect_on_association(:sender).macro).to eq(:belongs_to)
    end
    it 'belongs to a recipient' do
      expect(Message.reflect_on_association(:recipient).macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(FactoryBot.create(:message)).to be_valid
    end
    it 'is not valid without a sender' do
      expect(FactoryBot.build(:message, sender: nil)).to_not be_valid
    end
    it 'is not valid without a recipient' do
      expect(FactoryBot.build(:message, recipient: nil)).to_not be_valid
    end
    it 'is not valid without content' do
      expect(FactoryBot.build(:message, content: nil)).to_not be_valid
    end
    it 'is not valid with a content longer than 1000 characters' do
      expect(FactoryBot.build(:message, content: 'a' * 1001)).to_not be_valid
    end
  end
end
