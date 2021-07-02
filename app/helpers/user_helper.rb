module UserHelper
  def request_status(user)
    if current_user.pending_friends.include?(user)
      link_to 'Invitation pending', class: 'profile-link'
    elsif !current_user.friend_requests.include?(user) && !current_user.friends.include?(user) && current_user != user

      link_to 'Send friend request', "/users/#{user.id}/request", class: 'profile-link'
    elsif current_user.friend_requests.include?(user)

      concat(link_to('Accept Request', "/users/#{user.id}/accept", class: 'profile-link'))
      link_to ' | Decline Request', "/users/#{user.id}/decline", class: 'profile-link'
    end
  end
end
