class Public::DinnersController < ApplicationController
  before_action :authenticate_user!, except: [:top]
  before_action :set_dinner, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def top
  end

  def index
    @dinners = Dinner.with_active_users.order(created_at: :desc)
    @dinner = Dinner.new
    @my_recipes = current_user.recipes
  end

  def create
    @dinner = current_user.dinners.build(dinner_params)
  
    # 自分のレシピID一覧を取得
    my_recipe_ids = current_user.recipes.pluck(:id).map(&:to_s)
    selected_recipe_ids = params[:dinner][:recipe_ids].reject(&:blank?) # nilや""除外
  
    # 他人のレシピが含まれていたらエラー
    if (selected_recipe_ids - my_recipe_ids).any?
      @dinners = Dinner.with_active_users.order(created_at: :desc)
      @my_recipes = current_user.recipes
      flash.now[:alert] = '不正なレシピが選択されています。'
      render :index and return
    end
  
    if @dinner.save
      redirect_to dinner_path(@dinner), notice: '投稿が成功しました'
    else
      @dinners = Dinner.all.order(created_at: :desc)
      @my_recipes = current_user.recipes
      flash.now[:alert] = '投稿に失敗しました。必須項目を入力してください。'
      render :index
    end
  end
  

  def show
    @dinner = Dinner.find(params[:id])  # ← まず@dinnerを定義！
  
    # 退会済みユーザーの投稿なら一覧に戻す
    if @dinner.user.is_deleted?
      redirect_to dinners_path, alert: "この投稿は表示できません。"
      return
    end
  
    @comments = @dinner.comments
      .left_joins(:user)
      .where(users: { is_deleted: [false, nil] }) # ← 退会ユーザーのコメントは除外
      .order(created_at: :desc)
  
    @comment = Comment.new  # ← フォーム表示用の空のコメント
  end
  

  def edit
    @my_recipes = current_user.recipes
  end

  def update
    my_recipe_ids = current_user.recipes.pluck(:id).map(&:to_s)
    selected_recipe_ids = params[:dinner][:recipe_ids].presence || []
    
    selected_recipe_ids = selected_recipe_ids.reject(&:blank?) 

    if (selected_recipe_ids - my_recipe_ids).any?
      flash.now[:alert] = "不正なレシピが選択されています。"
      render :edit and return
    end
  
    if @dinner.update(dinner_params)
      redirect_to dinner_path(@dinner), notice: '更新しました'
    else
      flash.now[:alert] = "更新に失敗しました。必須項目を確認してください。"
      render :edit
    end
  end
  

  def destroy
    @dinner.destroy
    redirect_to mypage_path, notice: '削除しました'
  end

  private

  def set_dinner
    @dinner = Dinner.find(params[:id])
  end
  
  def ensure_correct_user
    unless @dinner.user == current_user
      redirect_to dinners_path, alert: '他の人の投稿は編集できません'
    end
  end

  def dinner_params
    params.require(:dinner).permit(:image, :title, :body, recipe_ids: [])
  end
end
