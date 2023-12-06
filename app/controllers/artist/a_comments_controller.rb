class Artist::ACommentsController < ApplicationController
  before_action :authenticate_artist!,{only:[:new]}

  def new
    @comment = AComment.new
  end

  def create
    @comment = AComment.new(comment_params)
    @comment.artist_id = current_artist.id
    if @comment.save
      redirect_to root_path,notice: 'ご意見ありがとうございます！'
    else
      flash[:alert] = "投稿できませんでした"
      render :new
    end
  end

  protected

  def comment_params
    params.require(:a_comment).permit( :artist_id, :title, :comment)
  end
end