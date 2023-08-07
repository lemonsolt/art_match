class Artist::PortfoliosController < ApplicationController
  before_action :authenticate_artist!,{only: [ :new, :create, :edit, :update, :destroy]}
  def index
     @portfolios = Portfolio.order(create_at: :DESC).page(params[:page])
  end

  def new
    @portfolio = Portfolio.new
  end

  def create
    @portfolio = Portfolio.new(portfolio_params)
    @portfolio.artist_id = current_artist.id
    genre_list=params[:portfolio][:name].split(',')

    if @portfolio.save
      @portfolio.save_genre(genre_list)
      redirect_to portfolios_path,notice: '投稿完了しました'
    else
      flash[:alert] = "データを保存できませんでした。"
      render :new
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
      render :edit
    end
  end

  def destroy
    @portfolio = Portfolio.find(params[:id])
    @portfolio.destroy
    redirect_to portfolios_path
  end

  private

  def portfolio_params
    params.require(:portfolio).permit( :artist_id, :title, :item, :introduction, :image,name: [])
  end
end
