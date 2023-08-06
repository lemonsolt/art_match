class Gallary::EventsController < ApplicationController
  def index
    @events = GallaryEvent.order(create_at: :DESC).page(params[:page])
  end

  def new
    @event = GallaryEvent.new
  end

  def create
    @event = GallaryEvent.new(event_params)
    @event.gallary_id = current_gallary.id
    @event.save
    redirect_to gallary_events_path
  end

  def show
    @event = GallaryEvent.find(params[:id])
  end

  def edit
    @event = GallaryEvent.find(params[:id])
  end

  def update
    @event = GallaryEvent.find(params[:id])
    @event.update(event_params)
    redirect_to gallary_event_path(@event.id)
  end

  def destroy
    @event = GallaryEvent.find(params[:id])
    @event.destroy
    redirect_to gallary_events_path
  end
    # 開催前のイベント一覧条件
  def before_index
    @events = GallaryEvent.where("start_at > ?",Date.today).order(start_at: :DESC)
  end
    # 開催中のイベント一覧条件
  def now_index
    @events = GallaryEvent.where("start_at <= ?",Date.today).and(GallaryEvent.where("end_at >= ?",Date.today)).order(start_at: :DESC)
  end
  # 開催終了日を過ぎたイベント一覧条件
  def after_index
    @events = GallaryEvent.where("end_at < ?",Date.today).order(end_at: :ASC)
  end

  private

  def event_params
    params.require(:gallary_event).permit( :gallary_id, :title,
    :introduction, :start_at, :end_at, :recruit, :image)
  end
end
