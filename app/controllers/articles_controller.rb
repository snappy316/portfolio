class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  def index
    @articles = policy_scope(Article)
  end

  # GET /articles/1
  def show
    @comment = @article.comments.build
    @comments = policy_scope(@article.comments)
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
    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
      current_user.articles << @article
    else
      render :new
    end
  end

  # PATCH/PUT /articles/1
  def update
    authorize @article
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article).permit(:title, :body, :image_url, (:published if current_user.role == "editor"))
  end
end
