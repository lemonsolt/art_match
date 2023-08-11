class Artist::HomesController < ApplicationController
  def top
    @events = GallaryEvent.joins(:gallary).where(gallaries: { is_cold: false, is_lock: false }).order(created_at: :DESC).page(params[:page]).per(4)
    @portfolios = Portfolio.joins(:artist).where(artists: { is_cold: false, is_lock: false }).order(created_at: :DESC).page(params[:page]).per(8)
  end
end
