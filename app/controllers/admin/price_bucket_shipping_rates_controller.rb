class Admin::PriceBucketShippingRatesController < Admin::BaseController    
  resource_controller
  before_filter :load_data
  layout 'admin'

  update.response do |wants|
    wants.html { redirect_to collection_url }
  end

  create.response do |wants|
    wants.html { redirect_to collection_url }
  end
    
  private
  def collection
    @collection ||= end_of_association_chain.all(:order => 'calculator_id DESC, price_floor ASC')
  end
	
  def load_data
    @available_calculators = Calculator::PriceBucket.find :all, :order => 'created_at DESC'
  end
end
