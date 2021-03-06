require 'test_helper'

class ChefsLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "mishymashy", email: "mishymash@example.com", password: "password")
  end
  
  test "reject invalid login" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {session: {email: " ", password: " "}}
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  test "valid login credentiols accepted and begin session" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {session: {email: @chef.email, password: @chef.password}}
    assert_redirected_to @chef
    follow_redirect!
    assert_template 'chefs/show'
    assert_not flash.empty?
  end
end
