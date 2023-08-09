class Artist::GtoaFollowsController < ApplicationController

  def create
    @artist = Artist.find_by(params[:artist_id])
    @artist_follow = current_gallary.gtoa_follows.create(artist_id: @artist.id)
    @artist_follow.save
    # redirect_back(fallback_location: root_path)
  end

  def destroy
    @artist = Artist.find_by(params[:artist_id])
    @artist_follow = current_gallary.gtoa_follows.find_by(artist_id: @artist.id)
    @artist_follow.destroy
    # redirect_back(fallback_location: root_path)
  end
end
