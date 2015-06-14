class UsersController < ApplicationController
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

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
