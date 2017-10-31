class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :update_description]
  before_action :correct_user,   only: [:edit, :update, :update_description]
  before_action :admin_user,     only: :destroy
  def new
    @user = User.new
  end

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    unless @user.activated?
      flash[:danger] = "Sorry, #{@user.name}'s account has not been activated."
      redirect_to root_url
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account. Allow
        a minute or two."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Another one bites the dust!"
    redirect_to users_url
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      render 'edit'
    end
  end

  # Resends activation email. This has its own 'reactivate' route (see
  # routes.rb) and the route is followed only via a link, contained in an error
  # flash, found at sessions_controller.rb.
  def reactivate
    @user = User.find(params[:id])
    @user.create_activation_digest
    @user.update_attribute(:activation_digest, @user.activation_digest)
    @user.send_activation_email
    flash[:info] = "Click the activation link we just emailed you,
                    and we'll log you in."
    redirect_to root_url
  end

  # Handles user's posted title and description.
  def update_description
    @user = User.find(params[:id])
    # For smart message, first check if user had a title.
    old_title = @user.title
    # For smart message, first check if user had a description.
    old_desc = @user.description
    if params[:user][:title]
      # And clear out any bad titles.
      session[:bad_title] = nil
      # Save title, if present.
      if params[:user][:title].present?
        # Attempt to save; if failed, flash with warning.
        begin
          @user.update_attributes!(title: params[:user][:title])
        rescue ActiveRecord::RecordInvalid
          flash[:warning] = "Unable to save. (Too long?)"
          session[:bad_title] = params[:user][:title]
        end
      elsif old_title
        @user.update_attributes!(title: nil)
        flash[:info] = "Title deleted."
      end
    elsif params[:user][:description]
      # And clear out any bad descriptions.
      session[:bad_desc] = nil
      # Save description, if present.
      if params[:user][:description].present?
        # Attempt to save; if failed, flash with warning.
        begin
          @user.update_attributes!(description: params[:user][:description])
        rescue ActiveRecord::RecordInvalid
          flash[:warning] = "Unable to save. (Too long?)"
          session[:bad_desc] = params[:user][:description]
        end
      elsif old_desc
        @user.update_attributes!(description: nil)
        flash[:info] = "Description deleted."
      end
    end
    # Same logic as before, now for description.
    # Make sure two different [:success] flashes work! Probably not!
    redirect_to "/users/#{@user.id}"
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Before filters

    # Confirms a user is in fact logged in.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms a user is in fact the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms that a user is an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
