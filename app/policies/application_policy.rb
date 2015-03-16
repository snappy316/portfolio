class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    # fail Pundit::NotAuthorizedError, "must be logged in" unless user
    @user = user || User.new
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(id: record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end


  def author?
    @user.role == "author"
  end

  def editor?
    @user.role == "editor"
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
