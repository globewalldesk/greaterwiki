require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "Spare Plans | Finding the Best Encyclopedia Articles Online"
    assert_select "div.header_search_form"
    assert_select "div.home_page_article_header", /GreaterWiki/
    assert_select "div.login_button"
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "Spare Plans | About Us"
    assert_select "div.login_button"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Spare Plans | Help and FAQ"
    assert_select "span.question"
    assert_select "span.answer"
  end

end
