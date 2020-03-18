class PickupPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end


  def review?
    record.driver == user && record.rating == nil
  end

  def new?
    user.class == User
  end

  def edit?
    record.user == user
  end

  def approve?
    review?
  end

  def disapprove?
    review?
  end

  def feedback?
    record.driver == user && record.rating == false
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
