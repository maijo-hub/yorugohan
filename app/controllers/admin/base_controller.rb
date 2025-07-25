# app/controllers/admin/base_controller.rb
class Admin::BaseController < ApplicationController
  layout 'admin'  # 管理者専用のレイアウトを使う

  before_action :authenticate_admin!  # Deviseでadminログインをチェック

  # （オプション）共通処理をここに書くこともできる
end
