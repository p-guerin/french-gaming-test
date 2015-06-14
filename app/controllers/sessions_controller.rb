class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where("username LIKE ? OR email LIKE ?", params[:login][:user], params[:login][:user]).first
    if user && user.authenticate(params[:login][:password])
      params[:login][:remember] == '1' ? remember(user) : forget(user)
      log_in user
      flash.now[:notice] = 'Log in successfuly'
      redirect_back_or root_path
    else
      flash.now[:notice] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
