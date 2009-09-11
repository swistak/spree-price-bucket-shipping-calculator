class PriceBucketShippingRate < ActiveRecord::Base
  belongs_to :shipping_method
  
  validates_presence_of :price_floor, :price_ceiling, :shipping_rate, :shipping_method

  named_scope :order_by_price_floor, :order => "price_floor"

  def self.get_shipping_rate(order_sub_total, calculator)
    # First try to find where price falls within price floor and ceiling
    bucket = find(:first, 
      :conditions => ["calculator_id = ? and ? between price_floor and price_ceiling",
        calculator.id, order_sub_total])

    # If no bucket selected, assume price is > largest bucket defined and use last bucket
    # for the given shipping method
    bucket ||= find(:last, :conditions => ['calculator_id = ?', calculator.id])
    
    bucket && bucket.shipping_rate
  end
  
  def <=>(other)
    self.price_floor <=> other.price_floor
  end
end
