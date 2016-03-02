class BusinessPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
  
  def index?
    record.groups.find_by(name: "#{record.name} Admin").memberships.exists?(user_id: user)
  end
  
  def show?
    index?
  end
  
  def new?
    index?
  end
  
  def create?
    index?
  end
  
  def edit?
    index?
  end
  
  def update?
    index?
  end
  
  def destroy?
    index?
  end
end
