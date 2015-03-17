class CommentsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    @comment = Comment.new(comment_params)
    @article = Article.find(@comment.article_id)

    if @comment.save
      redirect_to @article, notice: 'Comment submitted for approval'
      Article.find(@comment.article_id).comments << @comment
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:article_id, :content, :commenter_name, :commenter_url, :commenter_email)
  end

end
