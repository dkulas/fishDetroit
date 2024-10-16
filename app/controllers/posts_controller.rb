class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
    @post = set_post
  end

  def edit
    @post = set_post
  end

  def update
    @post = set_post
    if @post.update(post_params)
      redirect_to user_path(@post.user)
    else
      render 'edit'
    end
  end

  def destroy
    @post = set_post
    @post.destroy
    redirect_to root_path
  end

  def new
    @post = Post.new
  end

  def create
    @user = User.find(params[:user_id])  # Find the user first
    @post = @user.posts.build(post_params)  # Build the post associated with the user
    
    if @post.save
      # Redirect back to the user's profile page after a successful post creation
      redirect_to user_path(@user), notice: "Post created successfully."
    else
      # If the post fails to save, render the user's show page with form and posts
      @posts = @user.posts.order(created_at: :desc)
      render 'users/show'
    end
  end

  private

  def authorize_user!
    unless @post.user == current_user
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
