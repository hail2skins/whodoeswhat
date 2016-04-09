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
    Pundit.policy!(user, record.business).show?
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
