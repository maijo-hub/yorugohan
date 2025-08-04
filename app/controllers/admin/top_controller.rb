class Admin::TopController < ApplicationController
  before_action :authenticate_admin!

  def index
    # トップページ表示
  end
end
