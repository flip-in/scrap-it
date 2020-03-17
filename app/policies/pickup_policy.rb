class PickupPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  
  def review?
    record.driver == user
  end

  def new?
    user.class == User
  end

  def edit?
    record.user == user
  end

  def create?
    new?
  end

  def update?
    edit? || review?
  end

  def show?
    true
  end

  def destroy?
    edit?
  end

end
