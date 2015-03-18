class ArticlePolicy < ApplicationPolicy
  attr_accessor :user, :article

  def create?
    editor? || author?
  end

  def edit?
    editor? || authors_own?
  end

  def update?
    editor? || author?
  end

  def destroy?
    editor?
  end

  def publish?
    editor?
  end

  def authors_own?
    @user.id == @record.author_id
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user || User.new
      @scope = scope
    end

    def resolve
      if editor?
        scope.all
      elsif author?
        scope.where(author_id: user.id)
      else
        scope.where(published: true)
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
