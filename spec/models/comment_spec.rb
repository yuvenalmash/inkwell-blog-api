require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it 'belongs to a user' do
      expect(Comment.reflect_on_association(:user).macro).to eq(:belongs_to)
    end
    it 'belongs to a post' do
      expect(Comment.reflect_on_association(:post).macro).to eq(:belongs_to)
    end
    it 'has many likes' do
      expect(Comment.reflect_on_association(:likes).macro).to eq(:has_many)
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(FactoryBot.create(:comment)).to be_valid
    end
    it 'is not valid without content' do
      expect(FactoryBot.build(:comment, content: nil)).to_not be_valid
    end
    it 'is not valid without a user' do
      expect(FactoryBot.build(:comment, user: nil)).to_not be_valid
    end
    it 'is not valid without a post' do
      expect(FactoryBot.build(:comment, post: nil)).to_not be_valid
    end
    it 'is not valid with a content longer than 1000 characters' do
      expect(FactoryBot.build(:comment, content: 'a' * 1001)).to_not be_valid
    end
  end

  describe 'instance methods' do
    describe '#increment_comments_count' do
      it 'increments the user comments_count by 1' do
        user = FactoryBot.create(:user)
        post = FactoryBot.create(:post, user: user)
        expect { FactoryBot.create(:comment, user: user, post: post) }.to change { user.comments_count }.by(1)
      end
    end

    describe '#decrement_comments_count' do
      it 'decrements the user comments_count by 1' do
        user = FactoryBot.create(:user)
        post = FactoryBot.create(:post, user: user)
        comment = FactoryBot.create(:comment, user: user, post: post)
        expect { comment.destroy }.to change { user.comments_count }.by(-1)
      end
    end
  end
end
