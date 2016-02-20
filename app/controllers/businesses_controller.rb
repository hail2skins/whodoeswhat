class BusinessesController < ApplicationController
  
  def new
    @business = Business.new
  end
  
end
