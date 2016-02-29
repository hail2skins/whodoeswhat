class BusinessPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
  
  def index?
    record.groups.find_by(name: "#{record.name} Admin").memberships.exists?(user_id: user)
  end
end
