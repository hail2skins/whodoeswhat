# == Schema Information
#
# Table name: groups
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  business_id :integer
#

class GroupsController < ApplicationController
  before_action :get_business
  before_action :set_group, only: [:show]
  
def show
end
  
  
  private 
    def get_business
      @business = Business.find(params[:business_id])  
    end
    
    def set_group
      @group = @business.groups.find(params[:id])
    end
end
