class CommentPolicy < ApplicationPolicy
  attr_accessor :user, :comment

  def update?
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
        scope.where(approved: true)
      end
    end
  end
end
