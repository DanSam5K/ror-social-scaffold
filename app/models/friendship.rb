class Friendship < ApplicationRecord
  scope :pending_requests, -> { where(confirmed: false) }
  scope :accepted_requests, -> { where(confirmed: true) }

  belongs_to :user
  belongs_to :friend, class_name: 'User'
end

