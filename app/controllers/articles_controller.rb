class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  def index
    @articles = policy_scope(Article).order('created_at DESC').paginate(page: params[:page], per_page: 5)
  end

  # GET /articles/1
  def show
    set_comments
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    authorize @article
  end

  # POST /articles
  def create
    @article = Article.new(article_params)
    authorize @article

    respond_to do |format|
      format.html do
        if @article.save
          redirect_to @article, notice: 'Article was successfully created.'
          current_user.articles << @article
        else
          render :new
        end
      end

      format.js do
        if @article.save
          current_user.articles << @article
          set_comments
        else
          render :new, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /articles/1
  def update
    authorize @article

    respond_to do |format|
      format.html do
        if @article.update(article_params)
          redirect_to @article, notice: 'Article was successfully updated.'
        else
          render :edit
        end
      end

      format.js do
        @article.update(article_params)
        set_comments
      end
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
    respond_to do |format|
      format.html do
        redirect_to articles_url, notice: 'Article was successfully destroyed.'
      end

      format.js do
        # render layout: false
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  def set_comments
    @comment = @article.comments.build
    @comments = policy_scope(@article.comments)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article).permit(:title, :body, :image_url, :page, (:published if current_user.role == "editor"))
  end
end
