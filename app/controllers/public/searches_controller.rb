class Public::SearchesController < ApplicationController
  def search
    @target = params[:target]
    keyword = params[:keyword]

    if @target == "user"
      @users = User.where("username LIKE ?", "%#{keyword}%")
    elsif @target == "post"
      @recipes = Recipe.where("title LIKE ?", "%#{keyword}%")
      @dinners = Dinner.where("title LIKE ? OR body LIKE ?", "%#{keyword}%", "%#{keyword}%")
    else
      @users = []
      @recipes = []
      @dinners = []
    end
  end
end
