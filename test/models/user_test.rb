require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "Foobar12", password_confirmation: "Foobar12")
  end

  test "should be valid" do
    assert @user.valid?
  end


  # name tests #########################################################
  test "name should be present" do
    @user.name = "      "
    assert_not @user.valid?
  end

  test "name shouldn't be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end


  # email tests ########################################################
  test "email should be present" do
    @user.email = "      "
    assert_not @user.valid?
  end

  test "email shouldn't be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

    test "email validation should accept valid addresses" do
    valid_addresses = %w(user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice_bob@baz.cn)
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email is unique (and is not case-sensitive)" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should be saved as lowercase" do
    mixed_case_email = "fOo@BaR.com"
    @user.email = mixed_case_email
    @user.save
    assert_equal @user.reload.email, mixed_case_email.downcase
  end


  # password tests ########################################################
  test "password should be at least eight characters long" do
    @user.password = "a" * 7
    assert_not @user.valid?
  end

  test "passwords should include num and lc and uc letters" do
    @user.password = @user.password_confirmation = "abcdefgh"
    assert_not @user.valid?
    @user.password = @user.password_confirmation = "Abcdefgh"
    assert_not @user.valid?
    @user.password = @user.password_confirmation = "abcdefg5"
    assert_not @user.valid?
    @user.password = @user.password_confirmation = "Abcdefg5"
    assert @user.valid?
  end

  # profile tests ############################################################
  test "title and description cannot be too long" do
    @user.title = "x" * 256
    assert_not @user.valid?
    @user.description = "y" * 13_001
    @user.title = "x" * 10 # Don't want it to be invalid for this reason.
    assert_not @user.valid?
  end

  test "title and description are optional" do
    @user.valid? # Note, test user doesn't include these fields.
  end

  # other tests #############################################

  # Subtle issue: if a user logs out in Chrome but not in Firefox, he would
  # have no remember digest in the database, which would mean he'd be logged
  # in but not authenticated. That's not how it should work; he should be
  # logged out in absence of a remember digest.
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, "")
  end

end
