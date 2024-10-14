class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
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

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
