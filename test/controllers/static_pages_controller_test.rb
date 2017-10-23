require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "Start This! | Free ideas to change the world"
    assert_select "div.home_page_article_header", /StartThis/
    assert_select "div.login_button"
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "Start This! | About Us"
    assert_select "div.login_button"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Start This! | Help and FAQ"
    assert_select "p.question"
    assert_select "p.answer"
  end

end
