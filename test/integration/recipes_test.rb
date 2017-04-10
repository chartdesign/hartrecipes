require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = Chef.create!(chefname: "chefcookA1", email: "chefA1@itson.com")
    @recipe = Recipe.create(name: "potato soup", description: "good cheesy soup to warm you up", chef: @user)
    @recipe2 = @user.recipes.build(name: "chicken soup", description: "good chicken soup to warm you up")
    @recipe2.save
  end
  
 test "should get recipes index" do
   get recipes_url
   assert_response :success
 end
 
 test "should show a list of recipes" do 
   get recipes_path
   assert_template 'recipes/index'
   assert_match @recipe.name, response.body
   assert_match @recipe2.name, response.body
 end
 
end
