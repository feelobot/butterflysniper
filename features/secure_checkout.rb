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

  def self.register
  end

  def self.select_payment_method

  end

  def self.select_shipping
    
  end

  def self.enter_promo_code

  end

  def self.place_order

  end

  def order_products
  end


end