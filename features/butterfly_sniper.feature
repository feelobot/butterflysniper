Feature: Butterfly Sniper

Background:
  Given I am logged in to butterfly labs

Scenario: Buy Bitcoin Miner

  When I click the products tab
  When I the desired amount of each product
    And I proceed to checkout
    And I fill in my information
    And I place the order
  Then I should be able to mine bitcoins in 3 months
