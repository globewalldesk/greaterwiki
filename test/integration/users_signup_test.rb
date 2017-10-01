require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: "", email: "bogus@email",
                               password: "Foobar123", 
                               password_confirmation: "123" }
    end
    assert_template 'users/new'
  end
  
  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name: "Larry Sanger", 
                                    email: "yo.larrysanger@gmail.com",
                                    password: "Foobar123", 
                                    password_confirmation: "Foobar123" }
    end
    assert_not flash.empty?
    assert_template 'users/show'
    assert is_logged_in?
  end
  
  test "flash messages appear as expected" do
    get signup_path
    post_via_redirect users_path, user: { name: "Foo Bar", email: "good@ex.com",
                                          password: "FooB4rry", 
                                          password_confirmation: "FooB4rry" }
    assert flash[:success]
    assert_not flash[:danger]
    assert_select "div.alert"
    assert_select "div.alert-success"
    assert "div.alert-success", "Welcome to the Sample App!"
    post_via_redirect users_path, user: { name: "Foo Bar", email: "bad@ema%@il",
                                          password: "FooB4rry", 
                                          password_confirmation: "FooB4rry" }
    assert_select "div#error_explanation li", "Email is invalid."
    assert_select "div.alert"
    assert_select "div.alert-danger"
    post_via_redirect users_path, user: { name: "", email: "good@example.com",
                                          password: "FooB4rry", 
                                          password_confirmation: "FooB4rry" }
    assert_select "div#error_explanation li", "Name can't be blank."
    assert_select "div.alert"
    assert_select "div.alert-danger"
    post_via_redirect users_path, user: { name: "L S", email: "good@example.com",
                                          password: "FooB4rry", 
                                          password_confirmation: "FooBarry" }
    assert_select "div#error_explanation li", "Password confirmation doesn't match Password."
    assert_select "div.alert"
    assert_select "div.alert-danger" 
  end

end