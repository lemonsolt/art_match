class Gallary::GallariesController < ApplicationController
  def index
    @gallaries = Gallary.order("created_at DESC").page(params[:page])
  end

  def show
    @gallary = Gallary.find(params[:id])
    @events = @gallary.gallary_events.order("created_at DESC").page(params[:page])
  end

  def edit
    @gallary = current_gallary
  end

  def update
    @gallary = current_gallary
    if @gallary.update(gallary_params)
      redirect_to gallary_path(current_gallary.id)
    else
      render "edit"
      flash[:alert]
    end
  end

  def destroy

  end
  
  protected
  
  def gallary_params
    params.require(:gallary).permit( :name, :area_id, :introduction,
    :post_code, :address, :area_name, :image, :is_cold, gallary_images: [])
  end
end
