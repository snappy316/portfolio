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
end
