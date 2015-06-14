class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Bienvenue [nom] sur le site French Gaming. Pensez à valider votre inscription en cliquant sur le lien envoyer par e-mail."
      log_in @user
      redirect_to root_path
    else
      flash[:notice] = "Error Sign up."
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_edit_params)
      flash[:notice] = "Profile updated"
      redirect_to @user
    else
      flash[:notice] = "An error occurred"
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def user_edit_params
    params.require(:user).permit(:username, :email, :age, :city, :country, :image, :steam, :facebook, :twitter, :youtube, :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:notice] = "Please log in."
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
