Our client is an online marketplace, here is a sample of some of the products available on our site:

Product code  | Name                   | Price
----------------------------------------------------------
001           | Lavender heart         | £9.25
002           | Personalised cufflinks | £45.00
003           | Kids T-shirt           | £19.95
Our marketing team want to offer promotions as an incentive for our customers to purchase these items.

If you spend over £60, then you get 10% of your purchase

If you buy 2 or more lavender hearts then the price drops to £8.50.

Our check-out can scan items in any order, and because our promotions will change, it needs to be flexible regarding our promotional rules.# checkout
 
**ADDING PROMO CODES**

Promo codes allowed in promo_codes.rb

Checkout promo code price checking and application is made in checkout.rb:manipulate_prices. You can add local and global rules to manipulate the basket price in there.