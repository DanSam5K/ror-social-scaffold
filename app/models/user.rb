class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  # Helper methods
  def friends
    friendships.map { |friendship| friendship.friend if friendship.confirmed }.compact
  end

  # Users who have yet to confirmed friend requests
  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def accept_friendship(user_id)
    request = inverse_friendships.where(user_id: user_id).where(confirmed: false).first
  end

  def decline_friendship(user_id)
    request = inverse_friendships.where(user_id: user_id).where(confirmed: false).first
    request.destroy
  end
end
