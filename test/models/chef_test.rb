require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(chefname: "mushnigga", email: "goffy@eatemup.com")
  end
  
  test 'chef name should be valid' do
    assert @chef.valid?
  end
  
  test 'chef name should be present' do
    @chef.chefname = " "
    assert_not @chef.valid?
  end
  
  test 'Chef name should not be more than 30 characters' do
    @chef.chefname = "a" * 31
    assert_not @chef.valid?
  end
  
  test 'chef email should be present' do
    @chef.email = " "
    assert_not @chef.valid?
  end
  
  test 'Chef email should not be more than 255 characters' do
    @chef.email = "c" * 256
    assert_not @chef.valid?
  end
  
  test 'email should accept correct format' do
    valid_emails = %w[user@example.com joking@gti.co.uk sam+smith@yaoo.ca yilt@reli.org]
    valid_emails.each do |valids|
    @chef.email = valids
    assert @chef.valid?, "#{valids.inspect} should be valid"
    end
  end
  
  test 'email should reject incorrect format' do
    invalid_emails = %w[user@example joking@gtico,uk sam@+smith@yaoo+gil.ca yilt@reli.]
    invalid_emails.each do |invalids|
    @chef.email = invalids
    assert_not @chef.valid?, "#{invalids.inspect} should be invalid"
    end
  end
  
  test 'email should be unique and case insensitive' do
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
  end
  
  test 'email should be lowercase' do
    mixed_email = "JohN@eXXample.com"
    @chef.email = mixed_email
    @chef.save
    assert_equal mixed_email.downcase, @chef.reload.email
    
  end

  
  
end