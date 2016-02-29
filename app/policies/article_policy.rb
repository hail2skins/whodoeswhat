class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if scope.count == 0 || @business.groups.find_by(name: "#{scope.first.business.name} Admin").memberships.exists?(user_id: user)
        scope.all
      else
        raise Pundit::NotAuthorizedError
      end
    end
    
    def business
      @business = Business.find(business.id)
    end
  end

  def show?
    record.business.groups.find_by(name: "#{record.business.name} Admin").memberships.exists?(user_id: user)
  end
  
  def index?
    record.first.business.groups.find_by(name: "#{record.first.business.name} Admin").memberships.exists?(user_id: user)
  end
  

  
end
