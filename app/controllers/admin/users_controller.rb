# 例: app/controllers/admin/users_controller.rb
class Admin::UsersController < Admin::BaseController
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
end
