require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "GreaterWiki | Finding the Best Encyclopedia Articles Online"
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
