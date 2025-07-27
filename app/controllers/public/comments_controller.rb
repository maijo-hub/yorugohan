class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_comment_owner, only: [:destroy]

  def create
    @dinner = Dinner.find(params[:dinner_id])
    @comment = @dinner.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to dinner_path(@dinner), notice: "コメントを投稿しました"
    else
      flash[:alert] = "コメントを入力してください"
      redirect_to dinner_path(@dinner)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      flash[:notice] = "コメントを削除しました"
    else
      flash[:alert] = "他人のコメントは削除できません"
    end
    redirect_to dinner_path(@comment.dinner)
  end

  private
  def ensure_comment_owner
    @comment = Comment.find(params[:id])
    unless @comment.user == current_user
      redirect_to dinner_path(@comment.dinner), alert: "他人のコメントは削除できません"
    end
  end
  
  def comment_params
    params.require(:comment).permit(:content, :rating)
  end
end
