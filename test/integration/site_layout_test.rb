require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:tarik)
  end

  test "layout links including non-logged-in user" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", login_path
    assert_not_select "a[href=?]", logout_path
    assert_not_select "a[href=?]", users_path
    assert_not_select "a[href=?]", edit_user_path(@user)
    assert_not_select "a[href=?]", user_path(@user)
  end


  test "layout links including logged-in user" do
    get login_path
    assert_template 'sessions/new'
    assert_select "a[href=?]", signup_path

    log_in_as(@user)
    assert_redirected_to user_path(@user)
    follow_redirect!

    assert_not_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", user_path(@user)
  end
end
