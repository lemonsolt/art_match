class Gallary::GallariesController < ApplicationController
  before_action :authenticate_gallary!,{only: [:edit, :follows, :followers]}
  before_action :ensure_guest_gallary,{only: [:edit]}
  before_action :ensure_current_gallary,{only: [:edit,:update,:destroy]}

  def index
    @gallaries = Gallary.where("is_cold = ?",false).order(created_at: :DESC).page(params[:page]).per(15)
  end

  def show
    @gallary = Gallary.find(params[:id])
    @events = @gallary.gallary_events.order(created_at: :DESC).page(params[:page]).per(20)
  end

  def edit
    @gallary = current_gallary
  end

  def update
    @gallary = current_gallary
    if @gallary.update(gallary_params)
      redirect_to gallary_path(current_gallary.id), notice: "変更を保存しました。"
    else
      flash[:alert] = "項目を入力してください"
      render "edit"
    end
  end

  def destroy
    @gallary = Gallary.find(params[:id])
    @gallary.destroy
    redirect_to root_path, notice: "アカウントを削除しました。"
  end

  def follows
    gallary = Gallary.find(params[:id])
    unless gallary.id == current_gallary.id
      redirect_to root_path
    end
    @gallary = current_gallary
    follows = GtoaFollow.where(gallary_id: @gallary.id).pluck(:artist_id)
    @follow_artists = Artist.where(id: follows).order(:name)
    @follow_pages = @follow_artists.page(params[:page]).per(15)
  end

  def followers
    gallary = Gallary.find(params[:id])
    unless gallary.id == current_gallary.id
      redirect_to root_path
    end
    @gallary = current_gallary
    followers = AtogFollow.where(gallary_id: @gallary.id).pluck(:artist_id)
    @follower_artists = Artist.where(id: followers).order(:name)
    @follower_pages = @follower_artists.page(params[:page]).per(15)
  end

  def ensure_guest_gallary
    @gallary = Gallary.find(params[:id])
    if @gallary.email == "guest@example.com"
      redirect_to gallary_path(current_gallary), alert: "ゲストギャラリーはプロフィール編集画面へ遷移できません。"
    end
  end

  def ensure_current_gallary
    gallary = Gallary.find(params[:id])
    if gallary_signed_in?
      current_gallary = current_gallary

      if current_gallary && current_gallary == gallary
        redirect_to root_path, alert: "アカウントが違うため遷移できません。"
      end
    end
  end

  protected

  def gallary_params
    params.require(:gallary).permit( :name, :area_id, :introduction,
    :post_code, :address, :area_name, :image, :is_cold, :is_lock, gallary_images: [])
  end


end
