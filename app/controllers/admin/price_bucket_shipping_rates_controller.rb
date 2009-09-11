class Admin::PriceBucketShippingRatesController < Admin::BaseController    
  resource_controller
  before_filter :load_data
  layout 'admin'

  update.response do |wants|
    wants.html { redirect_to collection_url }
  end

  create.response do |wants|
    wants.html { 
      if params["create_another"]
        rate = params["price_bucket_shipping_rate"].dup
        rate[:price_floor] = rate.delete(:price_ceiling)
        redirect_to new_object_url+"?"+({"price_bucket_shipping_rate" => rate}.to_param)
      else
        redirect_to collection_url 
      end
    }
  end
    
  private
  def collection
    @collection ||= end_of_association_chain.all(:order => 'calculator_id DESC, price_floor ASC')
  end
	
  def load_data
    @available_calculators = Calculator::PriceBucket.find :all, :order => 'created_at DESC'
  end
end
