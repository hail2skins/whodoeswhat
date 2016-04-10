class ContactPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
  
  def index?
    Pundit.policy!(user, record.first.business).index?
  end
  
  def show?
    user.present? && user.groups.find_by(name: "#{record.business.name} Admin")
  end
  
  def create?
    show?
  end
  
  def update?
    show?
  end
  
  def destroy?
    show?
  end
end
