class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if scope.count == 0 || @business.groups.find_by(name: "#{scope.first.business.name} Admin").memberships.exists?(user_id: user)
        scope.all
      else
        raise Pundit::NotAuthorizedError
      end
    end
  end

  def show?
    Pundit.policy!(user, record.business).show?
  end
  
  def index?
    Pundit.policy!(user, record.first.business).index?
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
