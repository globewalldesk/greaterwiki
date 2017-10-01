class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    # If user is found and the password submitted is groovalicious, then...
    if @user && @user.authenticate(params[:session][:password])
      # ...log in and redirect to user's show page.
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to @user
    else
      flash.now[:danger] = 'Invalid email and/or password'
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
