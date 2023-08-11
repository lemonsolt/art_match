class Admin::GallariesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @gallaries = Gallary.order(create_at: :DESC).page(params[:page])
  end

  def show
    @gallary = Gallary.find(params[:id])
    @events = @gallary.gallary_events.order(created_at: :DESC).page(params[:page])
  end

  def edit
    @gallary = Gallary.find(params[:id])
  end

  def update
    @gallary = Gallary.find(params[:id])
    if @gallary.update(gallary_params)
      redirect_to admin_gallaries_path, notice: "変更を保存しました。"
    else
      render "edit"
      flash[:alert]
    end
  end

  protected

  def gallary_params
    params.require(:gallary).permit( :is_cold)
  end
end
