class ContactsController < ApplicationController
  before_action :get_business  
  before_action :set_contact, only: [ :show ]
  
  def index
    @contacts = @business.contacts
    respond_to do |format|
      format.html
      format.json { render json: @contacts.tokens(params[:q]) }
    end
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
