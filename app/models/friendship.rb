class Friendship < ApplicationRecord
  scope :pending_requests, -> { where(confirmed: false) }
  scope :accepted_requests, -> { where(confirmed: true) }

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def confirm_friend
    update_attribute('confirmed', true)
    Friendship.create!(
      friend_id: user_id,
      user_id: friend_id,
      confirmed: true
    )
  end
end
