class Artist::SearchesController < ApplicationController
  def index
    @genres = Genre.order(:name)
  end
  # 凍結状態でないアーティストの表示（非公開状態はカギマーク付きで表示される）
  def result
    @artists = Artist.where("is_cold == ?",false).order(:name).page(params[:page]).per(15)
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
