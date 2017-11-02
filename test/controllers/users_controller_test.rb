require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user       = users(:god)
    @other_user = users(:archer)
    @deletable_user = users(:mallory)
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?   # This user will try to make himself an admin.
    patch :update, id: @other_user, user: { password:              "Password9",
                                            password_confirmation: "Password9",
                                            admin: true }
    assert_not @other_user.reload.admin?
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @deletable_user
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @deletable_user
    end
    assert_redirected_to root_url
  end

  # NOTE! This isn't red and can't be until the controller method is written!
  test "only user can edit own title and description" do
    log_in_as(@user)
    assert_nil @other_user.title
    sad_title = "I am a man of constant sorrow."
    patch :update_description, id: @other_user, user:
      { title: sad_title }
    refute_equal @other_user.reload.title, sad_title
    assert_redirected_to root_url
  end

end
