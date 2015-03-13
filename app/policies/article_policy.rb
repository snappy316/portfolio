class ArticlePolicy < ApplicationPolicy
  attr_accessor :user, :article

  def initialize(user, article)
    # raise Pundit::NotAuthorizedError, "must be logged in" unless user
    @user = user
    @article = article
  end

  # --- CRUD ---

  def create?
    editor? || author?
  end

  def index?
    # Taken care of by the scope
  end

  def update?
    editor? || author?
  end

  def destroy?
    editor?
  end

  # --- HELPERS ---

  def author?
    @user.role == "author" if user_logged_in?
  end

  def editor?
    @user.role == "editor" if user_logged_in?
  end

  def publish?
    editor?
  end

  def user_logged_in?
    true unless @user.nil?
  end

  # --- SCOPE ---

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user_logged_in? && editor?
        scope.all
      elsif user_logged_in? && author?
        scope.where(author_id: user.id)
      else
        scope.where(published: true)
      end
    end

    def author?
      @user.role == "author" if user_logged_in?
    end

    def editor?
      @user.role == "editor" if user_logged_in?
    end

    def user_logged_in?
      true unless @user.nil?
    end
  end
end
