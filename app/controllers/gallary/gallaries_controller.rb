class Gallary::GallariesController < ApplicationController
  before_action :authenticate_gallary!,{only: [:edit, :follows, :followers]}
  before_action :ensure_guest_gallary!,{only: [:edit]}

  def index
    @gallaries = Gallary.order(created_at: :DESC).page(params[:page])
  end

  def show
    @gallary = Gallary.find(params[:id])
    @events = @gallary.gallary_events.order(created_at: :DESC).page(params[:page])
  end

  def edit
    @gallary = current_gallary
  end

  def update
    @gallary = current_gallary
    if @gallary.update(gallary_params)
      redirect_to gallary_path(current_gallary.id), notice: "変更を保存しました。"
    else
      render "edit"
      flash[:alert]
    end
  end

  def destroy
    @gallary = Gallary.find(params[:id])
    @gallary.delete
    redirect_to root_path, notice: "アカウントを削除しました。"
  end

  def follows
    @gallary = current_gallary
    follows = GtoaFollow.where(gallary_id: @gallary.id).pluck(:artist_id)
    @follow_artists = Artist.find(follows)
  end

  def followers
    @gallary = current_gallary
    followers = AtogFollow.where(gallary_id: @gallary.id).pluck(:artist_id)
    @follower_artists = Artist.find(followers)
  end
  
  def ensure_guest_gallary
    @gallary = Gallary.find(params[:id])
    if @gallary.email == "guest@example.com"
      redirect_to gallary_path(current_gallary), alert: "ゲストギャラリーはプロフィール編集画面へ遷移できません。"
    end
  end

  protected

  def gallary_params
    params.require(:gallary).permit( :name, :area_id, :introduction,
    :post_code, :address, :area_name, :image, :is_cold, gallary_images: [])
  end

  
end
