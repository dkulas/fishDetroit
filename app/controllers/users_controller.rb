class UsersController < ApplicationController
  before_action :authorized, only: [:show, :edit, :update, :update_password]
  before_action :set_user, only: [:edit, :update, :update_password, :destroy]
  
  def index
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Profile updated successfully."
    else
      render :edit
    end
  end

  def update_password
    if @user.authenticate(params[:user][:current_password])
      if @user.update(password_params)
        redirect_to @user, notice: "Password updated successfully."
      else
        flash[:alert] = "Error updating password."
        render :edit, status: :unprocessable_entity
      end
    else
      flash[:alert] = "Current password is incorrect."
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "Account created successfully."
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
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
    @user = current_user
    redirect_to root_path, alert: "You must be logged in." unless @user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
