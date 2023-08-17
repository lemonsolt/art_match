class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def index
    @genres = Genre.order(:name).page(params[:page]).per(50)
  end

  def show
    @genre = Genre.find(params[:id])
    @genre_portfolios = @genre.portfolios.order("created_at DESC").page(params[:page]).per(15)
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to admin_genres_path, notice: "ジャンルタグを削除しました。"
  end
end
