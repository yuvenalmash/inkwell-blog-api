require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it 'belongs to a user' do
      expect(Post.reflect_on_association(:user).macro).to eq(:belongs_to)
    end
    it 'has many comments' do
      expect(Post.reflect_on_association(:comments).macro).to eq(:has_many)
    end
    it 'has many likes' do
      expect(Post.reflect_on_association(:likes).macro).to eq(:has_many)
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(FactoryBot.create(:post)).to be_valid
    end
    it 'is not valid without a title' do
      expect(FactoryBot.build(:post, title: nil)).to_not be_valid
    end
    it 'is not valid without content' do
      expect(FactoryBot.build(:post, content: nil)).to_not be_valid
    end
    it 'is not valid without a slug' do
      expect(FactoryBot.build(:post, slug: nil)).to_not be_valid
    end
    it 'is not valid with a title longer than 100 characters' do
      expect(FactoryBot.build(:post, title: 'a' * 101)).to_not be_valid
    end
    it 'is not valid with a slug longer than 100 characters' do
      expect(FactoryBot.build(:post, slug: 'a' * 101)).to_not be_valid
    end
  end

  describe 'instance methods' do
    describe '#increment_posts_count' do
      it 'increments the user posts_count by 1' do
        user = FactoryBot.create(:user)
        expect { FactoryBot.create(:post, user: user) }.to change { user.posts_count }.by(1)
      end
    end

    describe '#decrement_posts_count' do
      it 'decrements the user posts_count by 1' do
        user = FactoryBot.create(:user)
        post = FactoryBot.create(:post, user: user)
        expect { post.destroy }.to change { user.posts_count }.by(-1)
      end
    end
  end
end
