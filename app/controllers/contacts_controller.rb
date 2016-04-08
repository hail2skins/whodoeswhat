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
  
  def new
    @contact = @business.contacts.new
  end
  
  def create
    @contact = @business.contacts.build(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to business_contact_path(@business, @contact), notice: "Contact created." }
      else
        format.html { render 'new' }
      end
    end
  end
  
  private
    def get_business
      @business = Business.find(params[:business_id])
    end
    
    def set_contact
      @contact = @business.contacts.find(params[:id])
    end
    
    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :email)
    end
end
