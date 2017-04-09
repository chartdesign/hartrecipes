require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def setup
    @recipe = Recipe.new(name: "veggie soup", description: "good ass soupy soup")
  end
  
  test 'recipe should be valid' do
    assert @recipe.valid?
  end
  
  test 'recipe should be present' do
    @recipe.name = " "
    assert_not @recipe.valid?
  end
  
  test 'desription should be present' do
    @recipe.description = " "
    assert_not @recipe.valid?
  end
  
  test 'description should not be less than 5 characters' do 
    @recipe.description = "abc"
    assert_not @recipe.valid?
  end
  
  test 'description should not be more than 500 characters' do
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end
  
end