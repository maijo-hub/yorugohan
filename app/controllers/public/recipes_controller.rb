class Public::RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @recipe = Recipe.new
    @recipes = Recipe.all.order(created_at: :desc)
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to public_recipes_path, notice: 'レシピを投稿しました'
    else
      @recipes = Recipe.all.order(created_at: :desc)
      render :index
    end
  end

  def show
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to public_recipe_path(@recipe), notice: 'レシピを更新しました'
    else
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    redirect_to public_recipes_path, notice: 'レシピを削除しました'
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description, :image)
  end
end
