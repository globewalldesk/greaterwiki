require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:god)
    @non_admin = users(:archer)
  end

  test "layout links for all users (incl. non-logged in)" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", signup_path
    get help_path
    assert_template 'static_pages/help'
    assert_select "a[href=?]", signup_path
  end
  
  test "layout Links for admin" do   # Should also test @non_admin case for now. 
    log_in_as(@admin)
    get root_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@admin)
    assert_select "a[href=?]", edit_user_path(@admin)
    assert_select "a[href=?]", logout_path
  end

end
