class Artist::SearchesController < ApplicationController
  def index
    @genres = Genre.order(:name)
  end

  def result
    @artists = Artist.order(:name).page(params[:page]).per(15)
    @keyword = search_params[:keyword]

    @search_artists = Artist.search(search_params[:keyword])
    @search_artist_all = @search_artists.all
    @search_artist = @search_artists.order(:name).page(params[:page]).per(15)

  end

  protected

  def search_params
    params.permit(:keyword)
  end
end
