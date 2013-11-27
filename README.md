butterflysniper
===============

Butterfly Labs Black Friday Promo Sniper

### Installation
git clone the repo and run bundle

### Config
Open config.json and change values as necessary. You must create a butterfly labs account before you can use this sniper.

**Optional Values:**
* middle_name
* company

**Configurable Values:**
* product
  * supported: 5GHS, 50GHS, 300GHS, 600GHS
  * note: do not add any more objects
* payment_method
  * supported: ach or btc
  * ach info does not need to be filled out if you choose ach
* use_billing_as_shipping
  * true or false

Run without purchaseing
```ruby
cucumber features/
```

Run with purchaseing
```ruby
cucumber features/ PAY=1
```

### Autorun
You can use a cronjob to run the command for you at midnight if you like using crontab -e for help search on how to make a cronjob. Keep in mind the time it runs is based on the time that the server is located on.
