class ArticlesController < ApplicationController
  before_action :get_business
  
  def index
  end
  
  
  
  private
    def get_business
      @business = Business.find(params[:business_id])
    end
end
