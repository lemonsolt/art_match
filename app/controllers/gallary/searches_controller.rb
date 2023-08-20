class Gallary::SearchesController < ApplicationController
  def index
  end

  def result
    @gallaries = Gallary.where("is_cold = ?",false).order(:name).page(params[:page]).per(15)
    @keyword = search_params[:keyword]
    @range = params[:range]

    if @range == "ギャラリー名"
      @names = Gallary.where("is_cold = ?",false).search(search_params[:keyword])
      @gallary_name_all = @names.all
      @gallary_name_page = @names.order(:name).page(params[:page]).per(15)
    elsif @range == "住所"
      @areas = Gallary.where("is_cold = ?",false).search_area(search_params[:keyword])
      @gallary_areas_all = @areas.all
      @gallary_area_page = @areas.order(:name).page(params[:page]).per(15)
    else
      @gallaries_page = @gallaries.order(:name).page(params[:page]).per(15)
    end


  end

  protected

  def search_params
    params.permit(:keyword)
  end
end
