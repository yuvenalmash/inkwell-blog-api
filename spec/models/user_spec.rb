require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'has many posts' do
      expect(User.reflect_on_association(:posts).macro).to eq(:has_many)
    end
    it 'has many comments' do
      expect(User.reflect_on_association(:comments).macro).to eq(:has_many)
    end
    it 'has many follows' do
      expect(User.reflect_on_association(:follows).macro).to eq(:has_many)
    end
    it 'has many likes' do
      expect(User.reflect_on_association(:likes).macro).to eq(:has_many)
    end
    it 'has many messages' do
      expect(User.reflect_on_association(:messages).macro).to eq(:has_many)
    end
    it 'has many followers' do
      expect(User.reflect_on_association(:followers).macro).to eq(:has_many)
    end
    it 'has many followed_users' do
      expect(User.reflect_on_association(:followed_users).macro).to eq(:has_many)
    end
    it 'has many liked_posts' do
      expect(User.reflect_on_association(:liked_posts).macro).to eq(:has_many)
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(FactoryBot.create(:user)).to be_valid
    end
    it 'is not valid without a username' do
      expect(FactoryBot.build(:user, username: nil)).to_not be_valid
    end
    it 'is not valid without an email' do
      expect(FactoryBot.build(:user, email: nil)).to_not be_valid
    end
    it 'is not valid without a password' do
      expect(FactoryBot.build(:user, encrypted_password: nil)).to_not be_valid
    end
    it 'is not valid with a username longer than 20 characters' do
      expect(FactoryBot.build(:user, username: 'a' * 21)).to_not be_valid
    end
    it 'is not valid with an email longer than 50 characters' do
      expect(FactoryBot.build(:user, email: 'a' * 51)).to_not be_valid
    end
    it 'is not valid with a duplicate username' do
      FactoryBot.create(:user, username: 'user')
      expect(FactoryBot.build(:user, username: 'user')).to_not be_valid
    end
    it 'is not valid with a duplicate email' do
      FactoryBot.create(:user, email: 'johndoe@email.com')
      expect(FactoryBot.build(:user, email: 'johndoe@email.com')).to_not be_valid
    end
  end

  describe 'instance methods' do
    it 'returns the number of posts' do
      user = FactoryBot.create(:user)
      FactoryBot.create_list(:post, 3, user: user)
      expect(user.posts_count).to eq(3)
    end
    it 'returns the number of comments' do
      user = FactoryBot.create(:user)
      FactoryBot.create_list(:comment, 3, user: user)
      expect(user.comments_count).to eq(3)
    end
    it 'returns the number of followers' do
      user = FactoryBot.create(:user)
      FactoryBot.create_list(:follow, 3, followed: user)
      expect(user.followers_count).to eq(3)
    end
  end
end
