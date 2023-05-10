require 'rails_helper'

RSpec.describe 'Follow', type: :model do
  describe 'associations' do
    it 'belongs to a follower' do
      expect(Follow.reflect_on_association(:follower).macro).to eq(:belongs_to)
    end
    it 'belongs to a followed' do
      expect(Follow.reflect_on_association(:followed).macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(FactoryBot.create(:follow)).to be_valid
    end
    it 'is not valid without a follower' do
      expect(FactoryBot.build(:follow, follower: nil)).to_not be_valid
    end
    it 'is not valid without a followed' do
      expect(FactoryBot.build(:follow, followed: nil)).to_not be_valid
    end
  end

  describe 'instance methods' do
    describe '#increment_followers_count' do
      it 'increments the followed followers_count by 1' do
        user = FactoryBot.create(:user)
        expect { FactoryBot.create(:follow, followed: user) }.to change { user.followers_count }.by(1)
      end
    end

    describe '#decrement_followers_count' do
      it 'decrements the followed followers_count by 1' do
        user = FactoryBot.create(:user)
        follow = FactoryBot.create(:follow, followed: user)
        expect { follow.destroy }.to change { user.followers_count }.by(-1)
      end
    end

    describe '#increment_followed_count' do
      it 'increments the follower followed_count by 1' do
        user = FactoryBot.create(:user)
        expect { FactoryBot.create(:follow, follower: user) }.to change { user.followed_count }.by(1)
      end
    end

    describe '#decrement_followed_count' do
      it 'decrements the follower followed_count by 1' do
        user = FactoryBot.create(:user)
        follow = FactoryBot.create(:follow, follower: user)
        expect { follow.destroy }.to change { user.followed_count }.by(-1)
      end
    end
  end
end
