class Admin::ArtistsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @aritsts = Artist.page(params[:page])
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])
    if @artist.update(artist_params)
      redirect_to admin_artists_path, notice: "変更を保存しました。"
    else
      render "edit"
      flash[:alert]
    end
  end

  private

  def artist_params
    params.require(:artist).permit( :is_cold)
  end

end
