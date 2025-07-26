# 例: app/controllers/admin/users_controller.rb
class Admin::UsersController < Admin::BaseController
  layout 'admin'
  before_action :authenticate_admin!
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    if @user.update(is_deleted: true)
      redirect_to admin_users_path, notice: 'ユーザーを退会処理しました。'
    else
      redirect_to admin_users_path, alert: '退会処理に失敗しました。'
    end
  end

  def restore
    @user = User.find(params[:id])
    if @user.update(is_deleted: false)
      redirect_to admin_user_path(@user), notice: 'ユーザーの利用状態を元に戻しました。'
    else
      redirect_to admin_user_path(@user), alert: '利用状態の変更に失敗しました。'
    end
  end
end
