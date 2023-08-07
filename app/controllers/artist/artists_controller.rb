class Artist::ArtistsController < ApplicationController
  before_action :authenticate_artist!,{only:[:edit, :update, :destroy]}

  def index
    @artists = Artist.order(name: :DESC).page(params[:page])
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
      redirect_to artist_path(current_artist.id)
    else
      render "edit"
      flash[:alert]
    end
  end

  def destroy

  end

  protected
  def artist_params
    params.require(:artist).permit( :name, :introduction, :is_cold, :image)
  end
end
