class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def request_friend
    request = current_user.friendships.build(friend_id: params['id'], confirmed: false)
    request.save
    flash[:notice] = 'Friend Request Successfully sent'
    redirect_to users_path
  end

  def accept_friend
    friendship = Friendship.find_by(user_id: params[:id])
    friendship.confirm_friend
    flash[:notice] = "You Accepted #{friendship.user.name}'s Friend Request!"
    redirect_to users_path
  end

  def decline_friend
    current_user.decline_friendship(params[:id])
    user = User.find(params[:id])

    flash[:notice] = "You Declined #{user.name}'s Friends Request"
    redirect_to users_path
  end
end
