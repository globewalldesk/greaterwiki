require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "GreaterWiki | Finding the Best Encyclopedia Articles Online"
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", help_path
    assert_select "div.header_search_form"
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "GreaterWiki | About Us"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "GreaterWiki | Help and FAQ"
  end

end
