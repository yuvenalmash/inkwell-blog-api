require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it 'belongs to a user' do
      expect(Like.reflect_on_association(:user).macro).to eq(:belongs_to)
    end
    it 'belongs to a likeable' do
      expect(Like.reflect_on_association(:likeable).macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(FactoryBot.create(:like)).to be_valid
    end
    it 'is not valid without a user' do
      expect(FactoryBot.build(:like, user: nil)).to_not be_valid
    end
    it 'is not valid without a likeable' do
      expect(FactoryBot.build(:like, likeable: nil)).to_not be_valid
    end
  end

  describe 'instance methods' do
    describe '#increment_likes_count' do
      it 'increments the likeable likes_count by 1' do
        post = FactoryBot.create(:post)
        expect { FactoryBot.create(:like, likeable: post) }.to change { post.likes_count }.by(1)
      end
    end

    describe '#decrement_likes_count' do
      it 'decrements the likeable likes_count by 1' do
        post = FactoryBot.create(:post)
        like = FactoryBot.create(:like, likeable: post)
        expect { like.destroy }.to change { post.likes_count }.by(-1)
      end
    end
  end
end
