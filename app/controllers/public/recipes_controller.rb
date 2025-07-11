class Public::RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy] 

  def index
    @recipe = Recipe.new
    @recipes = Recipe.all.order(created_at: :desc)
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to recipes_path, notice: 'レシピを投稿しました'
    else
      @recipes = Recipe.all.order(created_at: :desc)
      flash.now[:alert] = '投稿に失敗しました。必須項目を確認してください。'
      render :index
    end
  end

  def show
  end

  def edit
  end

 def update
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), notice: 'レシピを更新しました'
    else
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path, notice: 'レシピを削除しました'
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
   
  def correct_user
    unless @recipe.user == current_user
      redirect_to recipes_path, alert: "他の人のレシピは編集できません"
    end
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description, :image)
  end
end
