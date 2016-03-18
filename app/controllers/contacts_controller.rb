class ContactsController < ApplicationController
  before_action :get_business  
  before_action :set_contact, only: [ :show ]
  
  def index
    @contacts = @business.contacts.all
  end
  
  def show
    
  end
  
  private
    def get_business
      @business = Business.find(params[:business_id])
    end
    
    def set_contact
      @contact = @business.contacts.find(params[:id])
    end
  
end
