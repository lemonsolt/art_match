class Artist::HomesController < ApplicationController
  def top
    @events = GallaryEvent.order("created_at DESC").page(params[:page]).per(4)
    @portfolios = Portfolio.order("created_at DESC").page(params[:page]).per(8)
  end
end
