class Admin::TopController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    # トップページ表示
  end
end
