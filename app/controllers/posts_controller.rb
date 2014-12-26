class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @post = Post.new
    @posts = Post.order('created_at DESC').page(params[:page]).per(10)
    respond_with(@posts)
  end

  def show
    respond_with(@post)
  end

  def edit
    authenticate_owner!(@post)
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.save
    redirect_to edit_post_path(@post)
  end

  def update
    authenticate_owner!(@post)
    @post.update(post_params)
    respond_with(@post)
  end

  def destroy
    @post.destroy
    respond_with(@post)
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:user_id, :title, :permalink, :content)
    end

    def authenticate_owner!(post)
      redirect_to root_path if post.user != current_user
    end
end
