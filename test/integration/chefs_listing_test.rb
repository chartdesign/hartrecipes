require 'test_helper'

class ChefsListingTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "chefcookA1", email: "chefA1@itson.com",
                        password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "chefcookA2", email: "chefA2@itson.com",
                        password: "password1", password_confirmation: "password1")
  end
  
  test "should delete chef" do
    get chefs_path
    assert_template 'chefs/index'
    assert_difference 'Chef.count', -1 do
      delete chef_path(@chef2)
    end
    assert_redirected_to chefs_path
    assert_not flash.empty?
  end
end
