class BusinessesController < ApplicationController
  
  def new
    @business = Business.new
  end
  
  def create
    @business = Business.new(business_params)
    
    respond_to do |format|
      if @business.save
        create_group
        format.html { redirect_to current_user, notice: "Successfully created an association." }
      else
        format.html { render 'new' }
      end
    end
  end
  
  private
  
    def business_params
      params.require(:business).permit(:name)
    end
    
    
    def create_group
      Group.create!(name: group_name, user_id: current_user.id, business_id: @business.id)
    end
  
    def group_name
      "#{@business.name} Admin"
    end
  
end
