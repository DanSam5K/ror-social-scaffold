require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'belongs to a user' do
      friendship = Friendship.reflect_on_association(:user)
      expect(friendship.macro).to eq(:belongs_to)
    end

    it 'belongs to a user not has many' do
      friendship = Friendship.reflect_on_association(:user)
      expect(friendship.macro).not_to eq(:has_many)
    end

    it 'belongs to a friend' do
      friendship = Friendship.reflect_on_association(:friend)
      expect(friendship.macro).to eq(:belongs_to)
    end

    it 'belongs to a friend not has many' do
      friendship = Friendship.reflect_on_association(:friend)
      expect(friendship.macro).not_to eq(:has_many)
    end
  end
end
