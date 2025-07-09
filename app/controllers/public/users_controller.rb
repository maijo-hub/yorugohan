class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :confirm_withdrawal, :withdraw]

  def mypage
    @user = current_user
    @dinners = current_user.dinners.order(created_at: :desc)
    @recipes = current_user.recipes.order(created_at: :desc) # レシピも表示したい場合
  end
  
  def show
    @dinners = @user.dinners.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "プロフィールを更新しました"
    else
      render :edit
    end
  end

  def confirm_withdrawal
  end

  def withdraw
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: "退会が完了しました。ご利用ありがとうございました。"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :profile)
  end
end
