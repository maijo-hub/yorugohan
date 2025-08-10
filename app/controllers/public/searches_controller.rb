class Public::SearchesController < ApplicationController
  def search
    @target = params[:target]
    keyword = params[:keyword]

    if @target == "user"
      @users = User.active.where("username LIKE ?", "%#{keyword}%")
    elsif @target == "post"
      @recipes = Recipe.with_active_users.where("title LIKE ?", "%#{keyword}%")
      @dinners = Dinner.active.where("title LIKE ? OR body LIKE ?", "%#{keyword}%", "%#{keyword}%")
    else
      @users = []
      @recipes = []
      @dinners = []
    end
  end
end
