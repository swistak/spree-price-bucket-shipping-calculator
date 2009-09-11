class PriceBucketShippingRate < ActiveRecord::Base
  belongs_to :calculator
  
  validates_presence_of :price_floor, :price_ceiling, :shipping_rate

  named_scope :order_by_price_floor, :order => "price_floor"

  def self.get_shipping_rate(order_sub_total, calculator)
    # First try to find where price falls within price floor and ceiling
    bucket = find(:first, 
      :conditions => ["calculator_id = ? and ? between price_floor and price_ceiling",
        calculator.id, order_sub_total])

    if bucket
      return(bucket.shipping_rate)
    else
      # find largest one
      bucket = find(:last, :conditions => ['calculator_id = ?', calculator.id], :order => "price_ceiling DESC")
      # check if we've found largest one, and item_total is higher then ceiling
      if bucket && order_sub_total > bucket.price_ceiling
        return(bucket.shipping_rate)
      else
        return(false) # if there's no rates, or we've hit a hole, let calculator use default rate.
      end
    end
  end
  
  def <=>(other)
    self.price_floor <=> other.price_floor
  end
end
