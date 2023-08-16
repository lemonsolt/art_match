class Artist::GenresController < ApplicationController
  # そのジャンルタグのついた（アーティストが凍結も非公開状態でもない）ものを表示
  def show
    @genre = Genre.find(params[:id])
    @genre_portfolios = @genre.portfolios.joins(:artist)
                      .where("artists.is_cold = ? AND artists.is_lock = ?", false, false)
                      .order("created_at DESC").page(params[:page]).per(15)
  end
end
