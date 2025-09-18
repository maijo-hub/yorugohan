class Admin::ReviewsController < Admin::BaseController
  
  def index
    @comments = Comment.includes(:user, :dinner).where.not(rating: nil).order(created_at: :desc)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_reviews_path, notice: "レビューを削除しました"
  end
end
