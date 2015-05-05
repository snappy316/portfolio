class ProjectPolicy < ApplicationPolicy
  attr_accessor :user, :project

  def create?
    @user.editor?
  end

  def edit?
    @user.editor?
  end

  def update?
    @user.editor?
  end

  def destroy?
    @user.editor?
  end

  def publish?
    @user.editor?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user || User.new
      @scope = scope
    end

    def resolve
      if @user.editor?
        scope.all
      else
        scope.where(image_processed: true)
      end
    end
  end
end
