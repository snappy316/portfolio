class ArticlePolicy < ApplicationPolicy
  attr_accessor :user, :article

  def create?
    @user.editor? || @user.author?
  end

  def edit?
    @user.editor? || @user.id == @record.author_id
  end

  def update?
    @user.editor? || @user.author?
  end

  def destroy?
    @user.editor?
  end

  def publish?
    @user.editor?
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
      if @user.editor?
        scope.all
      elsif @user.author?
        scope.where(author_id: user.id)
      else
        scope.where(published: true)
      end
    end
  end
end
