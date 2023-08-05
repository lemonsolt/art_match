class Artist::ArtistsController < ApplicationController
  def index
    @artists = Artist.order(name: :DESC).page(params[:page])
  end

  def show
    @artist = Artist.find(params[:id])
    @portfolios_page = @artist.portfolios.page(params[:page])
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
