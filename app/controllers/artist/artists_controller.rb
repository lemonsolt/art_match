class Artist::ArtistsController < ApplicationController
  before_action :authenticate_artist!,{only:[:edit, :follows, :followers]}
  before_action :ensure_guest_artist!,{only: [:edit]}

  def index
    @artists = Artist.order(:name).page(params[:page])
  end

  def show
    @artist = Artist.find(params[:id])
    @portfolios = @artist.portfolios.order(create_at: :DESC).page(params[:page]).per(10)
  end

  def edit
    @artist = current_artist
  end

  def update
    @artist = current_artist
    if @artist.update(artist_params)
      redirect_to artist_path(current_artist.id), notice: "変更を保存しました。"
    else
      render "edit"
      flash[:alert]
    end
  end

  def destroy
    @artist = Artsit.find(params[:id])
    @artist.delete
    redirect_to root_path, notice: "アカウントを削除しました。"
  end

  def follows
    @artist = current_artist
    follows = AtogFollow.where(artist_id: @artist.id).pluck(:gallary_id)
    @follow_gallaries = Gallary.find(follows)
  end

  def followers
    @artist = current_artist
    followers = GtoaFollow.where(artist_id: @artist.id).pluck(:gallary_id)
    @follower_gallaries = Gallary.find(followers)
  end

  def ensure_guest_artist
    @artist = Artist.find(params[:id])
    if @artist.email == "guest@example.com"
      redirect_to artist_path(current_artist), alert: "ゲストアーティストはプロフィール編集画面へ遷移できません。"
    end
  end

  protected

  def artist_params
    params.require(:artist).permit( :name, :introduction, :is_cold, :image)
  end


end
