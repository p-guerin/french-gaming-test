module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    remember_token = User.new_token
    user.update_attribute(:remember_digest, remember_token)
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = remember_token
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.remember_digest == cookies[:remember_token]
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def forget(user)
    user.update_attribute(:remember_digest, nil)
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
end
