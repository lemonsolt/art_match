class Gallary::EventsController < ApplicationController
  before_action :authenticate_gallary!,{only: [:new, :create, :edit, :update, :destroy]}
  before_action :ensure_current_gallary,{only: [:edit,:update,:destroy]}

  def index
    @events = GallaryEvent.joins(:gallary).where(gallaries: { is_cold: false, is_lock: false }).order(created_at: :DESC).page(params[:page]).per(15)
  end

  def new
    @event = GallaryEvent.new
  end

  def create
    @event = GallaryEvent.new(event_params)
    @event.gallary_id = current_gallary.id
    if @event.save
      redirect_to gallary_events_path,notice: '投稿完了しました'
    else
      flash[:alert] = "投稿できませんでした"
      render :new
    end
  end

  def show
    @event = GallaryEvent.find(params[:id])
    @gallary = @event.gallary_id
  end

  def edit
    @event = GallaryEvent.find(params[:id])
  end

  def update
    @event = GallaryEvent.find(params[:id])
    @event.update(event_params)
    redirect_to edit_gallary_event_path(@event.id)
  end

  def destroy
    @event = GallaryEvent.find(params[:id])
    @event.destroy
    redirect_to gallary_events_path
  end
    # 開催前のイベント一覧条件（凍結や非公開の投稿ははじかれる）
  def before_index
    @events = GallaryEvent.joins(:gallary).where("start_at > ?", Date.today)
            .where(gallaries: { is_cold: false, is_lock: false })
            .order(:start_at).page(params[:page]).per(15)
  end
    # 開催中のイベント一覧条件
  def now_index
    @events = GallaryEvent.joins(:gallary).where("start_at <= ?",Date.today).and(GallaryEvent.where("end_at >= ?",Date.today))
            .where(gallaries: { is_cold: false, is_lock: false })
            .order(start_at: :DESC).page(params[:page]).per(15)
  end
  # 開催終了日を過ぎたイベント一覧条件
  def after_index
    @events = GallaryEvent.joins(:gallary).where("end_at < ?",Date.today)
            .where(gallaries: { is_cold: false, is_lock: false })
            .order(end_at: :DESC).page(params[:page]).per(15)
  end

  # before_action定義
  def ensure_current_gallary
    event = GallaryEvent.find(params[:id])
    gallary = event.gallary_id
    if gallary_signed_in?
      current_gallary = current_gallary

      if current_gallary && current_gallary == gallary
        redirect_to root_path, alert: "アカウントが違うため遷移できません。"
      end
    end
  end

  private

  def event_params
    params.require(:gallary_event).permit( :gallary_id, :title,
    :introduction, :start_at, :end_at, :recruit, :image)
  end

end
