class CommentPolicy < ApplicationPolicy
  attr_accessor :user, :article

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user || User.new
      @scope = scope
    end

    def resolve
      if editor?
        scope.all
      else
        scope.where(approved: true)
      end
    end

    def author?
      @user.role == "author"
    end

    def editor?
      @user.role == "editor"
    end
  end
end
