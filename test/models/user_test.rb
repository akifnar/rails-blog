require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Akif Nar", email: "akif@example.com",
                      password: "foobarbaz", password_confirmation: "foobarbaz")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name= "    "
    assert @user.invalid?
  end

  test "email should be present" do
    @user.email = ""
    assert @user.invalid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert @user.invalid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert @user.invalid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar first.last@foo.jp alice+bob@baz.cn]

    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid? "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_atfoo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert @user.invalid? "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert duplicate_user.invalid?
  end

  test "email addresses should be saved as lowercase" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert @user.invalid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 7
    assert @user.invalid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember ,'')
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    akif = users(:akif)
    tarik = users(:tarik)

    assert_not akif.following?(tarik)
    akif.follow(tarik)
    assert akif.following?(tarik)

    assert tarik.followers.include?(akif)
    akif.unfollow(tarik)
    assert_not akif.following?(tarik)

    akif.follow(akif)
    assert_not akif.following?(akif)
  end

  test "feed should have the right posts" do
    akif = users(:akif)
    tarik = users(:tarik)
    yakup = users(:yakup)
    # Post from followed user
    yakup.microposts.each do |post_following|
      assert akif.feed.include?(post_following)
    end
    # Self-posts for user with followers
    akif.microposts.each do |post_self|
      assert akif.feed.include?(post_self)
    end
    # Posts from non-followed user
    tarik.microposts.each do |post_unfollowed|
      assert_not akif.feed.include?(post_unfollowed)
    end
  end
end
