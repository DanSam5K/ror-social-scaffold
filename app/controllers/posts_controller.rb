class PostsController < ApplicationController
  before_action :authenticate_user!

  def show
    @post = current_user.posts.all
    @post = Post.where(current_user.confirmed == true).order('created_at DESC').paginate(page: params[:page],
                                                                                         per_page: 20)
    @user = User.all
  end

  def index
    @post = Post.new
    timeline_posts
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def timeline_posts
    @timeline_posts ||= Post.all.ordered_by_most_recent.includes(:user)
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
