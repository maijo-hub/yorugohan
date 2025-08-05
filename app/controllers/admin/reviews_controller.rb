class Admin::ReviewsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @comments = Comment.includes(:user, :dinner).where.not(rating: nil).order(created_at: :desc)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_reviews_path, notice: "レビューを削除しました"
  end
end
