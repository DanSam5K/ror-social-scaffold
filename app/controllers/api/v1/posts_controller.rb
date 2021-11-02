class Api::V1::PostsController < ApplicationController
    # before_action :authenticate_user!
    def index
        @posts = Post.all
        # render json: @products
        render json: {
            data: @posts,
            status: 200,
            message: "posts successfully"
          }, status: :ok
    end
end