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
 
 test 'create new valid recipe' do
   get new_recipe_path
   assert_template 'recipes/new'
   name_of_recipe = "chicken saute"
   description_of_recipe = "Add checken and vegebles and serve up the goodness."
   assert_difference 'Recipe.count', 1 do
     post recipes_path, params: {recipe: {name: name_of_recipe, description: description_of_recipe} }
   end
   follow_redirect!
   assert_match name_of_recipe.capitalize, response.body
   assert_match description_of_recipe, response.body
 end
 
 test "should reject invalid recipes" do
   get new_recipe_path
   assert_template 'recipes/new'
   assert_no_difference 'Recipe.count' do
     post recipes_path, params: {recipe: {name: "", description: ""}}
   end
   assert_template 'recipes/new'
   assert_select 'h2.panel-title'
   assert_select 'div.panel-body'
 end

 
end
