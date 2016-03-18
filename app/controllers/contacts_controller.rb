class ContactsController < ApplicationController
  before_action :get_business  
  
  def index
    @contacts = @business.contacts.all
  end
  
  private
    def get_business
      @business = Business.find(params[:business_id])
    end
  
end
