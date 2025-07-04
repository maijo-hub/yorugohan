class Public::DinnersController < ApplicationController
  before_action :set_dinner, only: [:show, :edit, :update, :destroy]

  def top
    @dinners = Dinner.all
  end

  def index
    @dinners = Dinner.all
  end

  def new
    @dinner = Dinner.new
  end

  def create
    @dinner = Dinner.new(dinner_params)
    @dinner.user_id = current_user.id
    if @dinner.save
      redirect_to dinners_path, notice: '投稿が成功しました'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @dinner.update(dinner_params)
      redirect_to dinner_path(@dinner), notice: '更新しました'
    else
      render :edit
    end
  end

  def destroy
    @dinner.destroy
    redirect_to dinners_path, notice: '削除しました'
  end

  private

  def set_dinner
    @dinner = Dinner.find(params[:id])
  end

  def dinner_params
    params.require(:dinner).permit(:image, :title, :body, :tag_list)
  end
end

