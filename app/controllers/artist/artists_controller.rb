class Artist::ArtistsController < ApplicationController
  before_action :authenticate_artist!,{only:[:edit, :follows, :followers]}
  before_action :ensure_guest_artist,{only: [:edit]}

  def index # 凍結されたアカウント以外を表示
    @artists = Artist.where("is_cold = ?",false).order(:name).page(params[:page]).per(10)
  end

  def show
    @artist = Artist.find(params[:id])
    @portfolios = @artist.portfolios.order(created_at: :DESC).page(params[:page]).per(12)
  end

  def edit
    @artist = current_artist
  end

  def update
    @artist = current_artist
    if @artist.update(artist_params)
      redirect_to artist_path(current_artist.id), notice: "変更を保存しました。"
    else
      flash[:alert] = "データを保存できませんでした。"
      render "edit"
    end
  end

  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy
    redirect_to root_path, notice: "アカウントを削除しました。"
  end

  def follows
    @artist = current_artist
    follows = AtogFollow.where(artist_id: @artist.id).pluck(:gallary_id)
    @follow_gallaries = Gallary.where(id: follows).order(:name)
    @follow_pages = @follow_gallaries.page(params[:page]).per(15)
  end

  def followers
    @artist = current_artist
    followers = GtoaFollow.where(artist_id: @artist.id).pluck(:gallary_id)
    @follower_gallaries = Gallary.where(id: followers).order(:name)
    @follower_pages = @follower_gallaries.page(params[:page]).per(15)
  end



  protected

  def artist_params
    params.require(:artist).permit( :name, :introduction, :is_cold, :is_lock , :image)
  end

  def ensure_guest_artist
    @artist = Artist.find(params[:id])
    if @artist.email == "guest@example.com"
      redirect_to artist_path(current_artist), alert: "ゲストアーティストはプロフィール編集画面へ遷移できません。"
    end
  end
  
  


end
