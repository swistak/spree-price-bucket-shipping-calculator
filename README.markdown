Price Bucket Shipping Rate
==========================
**Supports Spree >= 0.9.x**

Original code by Michael Lang
Adapted for new calculators by Marcin Raczkowski.

old version that works with 0.8 code can be found at http://github.com/mwlang/spree-price-bucket-shipping-calculator/tree/master

The Price Bucket Shipping Rate Calculator allows you to define shipping costs based on the order's sub-total
and shipping method.

When installed, a new "Price Bucket Shipping Rates" link is added to the Configuration area in the Spree administration interface. 
There after creating named PriceBucket calculator you can define as many different rates as required,
and link them to the relevant Calculator.

Each PriceBucketShippingRate contains the following values:

1. **Calculator:** Each PriceBucketShippingRate is associated with a _Calculator_, which is used to calculate charges.

2. **Price Floor:** This is the lower end of the price range for defining the "price bucket".  The value is inclusive.

3. **Price Ceiling:** This is the upper end of the price range for defining the "price bucket"   The value is inclusive.

4. **Shipping Rate:** Is the shipping charge to apply to the order for order's whose sub-totals fall within this price bucket.

Quick Start
===========
1. Install extension:

    `script/extension install git://github.com/swistak/spree-price-bucket-shipping-calculator.git`

2. Migrate the database (or bootstrap if you want the sample data for testing)

    `rake db:migrate`
