Given(/^I am logged in to butterfly labs$/) do
  @checkout_page = SecureCheckout.new
end
When(/^I click the products tab$/) do
  Capybara.click_link 'Products'  
end

When(/^I the desired amount of each product$/) do
  @checkout_page.add_products_to_cart
end

When(/^I proceed to checkout$/) do
  Capybara.click_link 'Checkout'
end

When(/^I fill in my information$/) do
  @checkout_page.fill_information
end

When(/^I select my shipping method$/) do
  @checkout_page.select_shipping_method
end

When(/^I select my payment mehtod$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I enter the promo code$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I place the order$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should be able to mine bitcoins in (\d+) months$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end