class Public::PostImagesController < ApplicationController
  before_action :authenticate_user!  # ログイン必須なら
  before_action :set_post_image, only: [:show, :edit, :update, :destroy]

  def index
    @post_images = PostImage.all.order(created_at: :desc)
  end

  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    if @post_image.save
      redirect_to post_images_path, notice: '投稿が成功しました'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post_image.update(post_image_params)
      redirect_to post_image_path(@post_image), notice: '更新しました'
    else
      render :edit
    end
  end

  def destroy
    @post_image.destroy
    redirect_to post_images_path, notice: '削除しました'
  end

  private

  def set_post_image
    @post_image = PostImage.find(params[:id])
  end

  def post_image_params
    params.require(:post_image).permit(:image, :description, :tag_list)
  end
end

