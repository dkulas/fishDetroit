class UsersController < ApplicationController
  before_action :authorized, only: [:show]
  before_action :set_user, only: [:destroy]
  
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @post = Post.new
    @posts = @user.posts.order(created_at: :desc)
  end

  def destroy
    if @user == current_user
      @user.destroy
      reset_session # Logs out the user
      flash[:notice] = "Your account has been successfully deleted."
      redirect_to root_path
    else
      flash[:alert] = "You can only delete your own account."
      redirect_back fallback_location: root_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
