require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:god)
    @non_admin = users(:archer)
  end

  test "should not show user/<id> if user is not activated" do
    @non_admin.update_attribute(:activated, false)
    log_in_as(@admin)
    get user_path(@non_admin)
    assert_redirected_to root_url
    assert flash[:danger]
  end

  test "profile submits new title successfully (or not)" do
    log_in_as(@non_admin)
    get user_path(@non_admin)
    assert_nil @non_admin.title
    patch "/users/#{@non_admin.id}/update_description", user:
      { title: "I am a man of constant sorrow." }
    user = assigns(:user)
    user.reload.title
    assert user.title == "I am a man of constant sorrow."
    assert_redirected_to user_url(@non_admin)
    patch "/users/#{user.id}/update_description", user:
          { title: "x" * 256 }
    assert flash[:warning] # JS should disallow submission, so it doesn't
                               # get this far.
  end

  test "profile submits new description successfully (or not)" do

  end

end
