class CommentsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)

    if @comment.save
      redirect_to @article, notice: 'Comment submitted for approval'
      Article.find(@comment.article_id).comments << @comment
    else
      render :new
    end
  end

  def update
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])

    authorize @comment
    if @comment.update(comment_params)
      redirect_to @article, notice: 'Comment was successfully approved.'
    else
      redirect_to @article, error: 'Comment not approved.'
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])

    @comment.destroy
    redirect_to @article, notice: 'Comment was deleted.'
  end

  private

  def comment_params
    params.require(:comment).permit(:approved, :article_id, :content, :commenter_name, :commenter_url, :commenter_email)
  end
end
