class Calculator::PriceBucket < Calculator
  has_one :price_bucket_shipping_rate, :as => :calculator
  
  preference :default_amount, :decimal, :default => 0
  preference :name, :string

  def self.description
    I18n.t("price_bucket")
  end

  def self.register
    super
    Coupon.register_calculator(self)
    ShippingMethod.register_calculator(self)
    ShippingRate.register_calculator(self)
  end

  # as object we always get line items, as calculable we have Coupon, ShippingMethod or ShippingRate
  def compute(object)
    if object.is_a?(Array)
      item_total = object.map{ |o| o.respond_to?(:amount) ? o.amount : o.to_d }.sum
    else
      item_total = object.respond_to?(:amount) ? object.amount : object.to_d
    end

    PriceBucketShippingRate.get_shipping_rate(item_total, self) || self.preferred_default_amount
  end

  def name
    self.preferred_name
  end
end