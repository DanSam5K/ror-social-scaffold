class Friendship < ApplicationRecord
  scope :pending_requests, -> { where(confirmed: false) }
  scope :accepted_requests, -> { where(confirmed: true) }

  belongs_to :user
  belongs_to :friend, class_name: 'User'
end

def confirm_friend
  self.update_attributes(confirmed: true)
  Friendship.create!(
      friend_id: self.user_id,
      user_id: self.friend_id,
      confirmed: true
  )
end
