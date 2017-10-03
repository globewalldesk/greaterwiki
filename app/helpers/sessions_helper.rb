module SessionsHelper
  
  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # Remembers a user in a persistent session. Saves info in perm cookies.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end
  
  # Returns the current logged-in user (if any).
  def current_user
    # First check if there is a temporary cookie with :user_id; use that if so.
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id])
    # Otherwise, check for a permanent cookie with :user_id, and use that to
    # log the user in.
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user # Returns this value.
      end
    end
  end
  
  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end
  
  # Forgets a permanent session.
  def forget(user)
    user.forget
    # After this is deleted, the user won't have a perm. cookie to log in with.
    cookies.delete(:user_id)
    # Even if user puts an ID in the cookie by hand, he won't have a token we gave him.
    cookies.delete(:remember_token)
  end
  
  # Logs out the current user.
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end
  
  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
  
end