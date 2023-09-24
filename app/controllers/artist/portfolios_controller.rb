class Artist::PortfoliosController < ApplicationController
  before_action :authenticate_artist!,{only: [ :new, :create, :edit, :update, :destroy]}
  before_action :ensure_current_artist,{only: [:edit,:update,:destroy]}

  def index
    @portfolios = Portfolio.joins(:artist).where(artists: { is_cold: false, is_lock: false }).order(created_at: :DESC).page(params[:page]).per(20)
  end

  def new
    @genre_list = Genre.all.pluck(:name).join(", ")
    @portfolio = Portfolio.new
  end

  def create
    @portfolio = Portfolio.new(portfolio_params)
    @portfolio.artist_id = current_artist.id
    genre_list=params[:portfolio][:name].split(',')
    # トランザクション文章
    Portfolio.transaction do
      if @portfolio.save
        @portfolio.save_genre(genre_list)
        redirect_to portfolios_path,notice: '投稿完了しました'
      else
        flash[:alert] = "データを保存できませんでした。"
        render :new
      end
    # レスキュー処理文章
    rescue ActiveRecord::RecordInvalid => exception
      flash[:alert] = "データを保存できませんでした。"
      redirect_to portfolios_path
    end
  end

  def show
    @portfolio = Portfolio.find(params[:id])
    @portfolio_genres = @portfolio.portfolio_genres
  end

  def edit
    @portfolio = Portfolio.find(params[:id])
    @genre_list = @portfolio.genres.pluck(:name).join(', ')
  end

  def update
    @portfolio = Portfolio.find(params[:id])
    genre_list=params[:portfolio][:name].split(',')
    if  @portfolio.update(portfolio_params)
      @old_relations=PortfolioGenre.where(portfolio_id: @portfolio.id)
      @old_relations.each do |relation|
        relation.delete
      end
      @portfolio.save_genre(genre_list)
      redirect_to portfolio_path(@portfolio.id),notice: '変更完了しました'
    else
      flash[:alert] = "データを変更できませんでした。"
      redirect_to edit_portfolio_path(@portfolio.id)
    end
  end

  def destroy
    @portfolio = Portfolio.find(params[:id])
    @portfolio.destroy
    redirect_to portfolios_path
  end

  # before_action定義
  def ensure_current_artist
  portfolio = Portfolio.find(params[:id])
  artist = portfolio.artist_id
    if artist_signed_in?
      current_artist = current_artist # current_artist の設定方法はアプリケーションに依存します

      if current_artist && current_artist.id == artist
        redirect_to root_path, alert: "アカウントが違うため遷移できません。"
      end
    end
  end


  private

  def portfolio_params
    params.require(:portfolio).permit( :artist_id, :title, :item, :introduction, :image,name: [])
  end
end
