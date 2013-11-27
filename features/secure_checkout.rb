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

  def register
  end

  def fill_information
    Capybara.fill_in "First Name", :with => @config["first_name"]
    Capybara.fill_in "Middle Name", :with => @config["middle_name"]
    Capybara.fill_in "Last Name", :with => @config["last_name"]
    
  end

  def add_products_to_cart
    for product in @config["products"]
      puts product["name"]
      puts product["qty"]
      unless product["qty"] == "0" || product["qty"] == "" || product["qty"] == nil
        case product["name"]
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
        Capybara.fill_in "qty", :with => product["qty"]
        Capybara.click_button "Add to Cart"
      end
    end
        

  end


end