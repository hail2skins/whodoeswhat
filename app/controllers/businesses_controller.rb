# == Schema Information
#
# Table name: businesses
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BusinessesController < ApplicationController
  
  def new
    @business = Business.new
  end
  
  def create
    @business = Business.new(business_params)
    respond_to do |format|
      if @business.save
        create_group
        create_membership
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
      @group = Group.create!(name: group_name, 
                             description: group_description,
                             business_id: @business.id)
    end
    
    def create_membership
      @group.memberships.create!(user_id: current_user.id)
    end
  
    def group_name
      "#{@business.name} Admin"
    end
    
    def group_description
      "Default admin group created to associate a user with a business
      and allow the user to post."
    end
  
end
