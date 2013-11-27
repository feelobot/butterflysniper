Feature: Butterfly Sniper

Background:
  Given I am logged in

Scenario: Buy Bitcoin Miner

When I Visit butterflylabs website
  And I click the products tab
When I select the desired product
  And add the qty I need into the cart
  And I proceed to checkout
When I checkout securely
