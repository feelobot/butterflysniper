require 'capybara/cucumber'
require "selenium-webdriver"
require "cucumber"

class SecureCheckout
  def initialize
    load_config
    Capybara.default_driver = :selenium
    Capybara.visit 'http://www.butterflylabs.com/'
    login unless logged_in?
  end

  def load_config
    config_file = File.read(File.expand_path("../../config.json", __FILE__))
    @config = JSON.parse(config_file)
  end

  def login
    Capybara.click_link 'LOGIN'
    Capybara.fill_in 'Email', :with => @config["username"]
    Capybara.fill_in 'pass', :with => @config["password"]
    Capybara.click_button 'Login'
    raise "Login Failed!" unless logged_in?
  end

  def logged_in?
    Capybara.page.has_content?('Log Out')
  end

  def fill_information
    unless Capybara.has_css? "select#billing_customer_address" then
      Capybara.fill_in "billing:firstname", :with => @config["first_name"]
      Capybara.fill_in "billing:middlename", :with => @config["middle_name"]
      Capybara.fill_in "billing:lastname", :with => @config["last_name"]
      Capybara.fill_in "billing:company", :with => @config["billing_address"]["company"]
      Capybara.select ["billing_address"]["country"], :from => "Country" unless @config["billing_address"]["country"] == "United States"
      Capybara.fill_in "billing:street1", :with => @config["billing_address"]["address"]
      Capybara.fill_in "billing:street2", :with => @config["billing_address"]["address2"]
      Capybara.fill_in "City", :with => @config["billing_address"]["city"]
      sleep 1
      Capybara.select @config["billing_address"]["state-province"], :from => "billing:region_id"
      Capybara.fill_in "billing:postcode", :with => @config["billing_address"]["zipcode"]
      Capybara.fill_in "Telephone", :with => @config["billing_address"]["telephone"]
    end
    
    Capybara.select "New Address", :from => "shipping_address_id" if Capybara.has_css? "select#billing_customer_address" && ( @config["shipping_address"]["address"] == "" || @config["shipping_address"]["address"] == " " || @config["shipping_address"]["address"] == nil)

    unless @config["shipping_address"]["address"] == "" || @config["shipping_address"]["address"] == " " || @config["shipping_address"]["address"] == nil
      Capybara.uncheck "shipping:same_as_billing" 
      Capybara.fill_in "shipping:firstname", :with => @config["first_name"]
      Capybara.fill_in "shipping:middlename", :with => @config["middle_name"]
      Capybara.fill_in "shipping:lastname", :with => @config["last_name"]
      Capybara.fill_in "shipping:company", :with => @config["shipping_address"]["last_name"]
      Capybara.select @config["shipping_address"]["country"], :from => "shipping:country_id" unless @config["shipping_address"]["country"] == "United States"
      Capybara.fill_in "shipping:street1", :with => @config["shipping_address"]["address"]
      Capybara.fill_in "shipping:street2", :with => @config["shipping_address"]["address2"]
      Capybara.fill_in "City", :with => @config["shipping_address"]["city"]
      sleep 1
      Capybara.select @config["shipping_address"]["state-province"], :from => "shipping:region_id"
      Capybara.fill_in "shipping:postcode", :with => @config["shipping_address"]["zipcode"]
      Capybara.fill_in "shipping[telephone]", :with => @config["shipping_address"]["telephone"]
    end
  end

  def add_products_to_cart
    unless @config["product"]["qty"] == "0" || @config["product"]["qty"] == "" || @config["product"]["qty"] == nil
      case @config["product"]["name"]
      when "5GHS"
        Capybara.visit 'https://products.butterflylabs.com/homepage/5-gh-s-bitcoin-miner.html'
      when "50GHS"
        Capybara.visit 'https://products.butterflylabs.com/homepage/50-gh-s-bitcoin-miner.html'
      when "300GHS"
        Capybara.visit 'https://products.butterflylabs.com/homepage-new-products/300-gh-bitcoin-mining-card.html'
      when "600GHS"
        Capybara.visit 'https://products.butterflylabs.com/homepage-new-products/600-gh-bitcoin-mining-card.html'
      else
        raise "Could not find product!"
      end
      Capybara.fill_in "qty", :with => @config["product"]["qty"]
      Capybara.click_button "Add to Cart"
    end
  end
  def select_shipping_method
    case @config["shipping_method"]
    when "standard"
      Capybara.choose "s_method_bflshipping_bflshipping"
    when "express"
      Capybara.choose "s_method_bflexpressshipping_bflexpressshipping"
    else
      raise "Incorrect shipping method"
    end
  end

  def select_payment_method
    case @config["payment_method"]
    when "ach"
      Capybara.choose "p_method_avantiach"
      Capybara.select @config["ach"]["account_type"], :from => "avantiach_acc_type"
      Capybara.fill_in "avantiach_acc_nr", :with => @config["ach"]["account_number"]
      Capybara.fill_in "avantiach_acc_trn", :with => @config["ach"]["routing_number"]
    when "btc"
      Capybara.choose "p_method_Bitcoins"
    else
      raise "Payment Method Not Supported, Only btc or ach"
    end
  end

  def add_promo_code
    Capybara.fill_in "coupon-code", :with => "BFLBLACKFRIDAY"
    Capybara.click_button "Apply Coupon"
  end

  def place_order
    Capybara.check "checkout_terms_checkbox"
    Capybara.click_button "Place Order" if ENV['PAY'] == "1"
  end
end
After do |scenario|
    sleep 1500
end