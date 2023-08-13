class Gallary::AtogFollowsController < ApplicationController

  def create
    @gallary = Gallary.find_by(id: params[:gallary_id])
    @gallary_follow = current_artist.atog_follows.create(gallary_id: @gallary.id)
    @gallary_follow.save
    # redirect_back(fallback_location: root_path)
  end

  def destroy
    @gallary = Gallary.find_by(id: params[:gallary_id])
    @gallary_follow = current_artist.atog_follows.find_by(gallary_id: @gallary.id)
    @gallary_follow.destroy
    # redirect_back(fallback_location: root_path)
  end
end
 