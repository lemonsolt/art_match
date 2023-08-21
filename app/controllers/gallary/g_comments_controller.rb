class Gallary::GCommentsController < ApplicationController
  before_action :authenticate_gallary!,{only:[:new]}

  def new
    @comment = GComment.new
  end

  def create
    @comment = GComment.new(comment_params)
    @comment.gallary_id = current_gallary.id
    if @comment.save
      redirect_to root_path,notice: 'ご意見ありがとうございます！'
    else
      flash[:alert] = "投稿できませんでした"
      render :new
    end
  end

  protected

  def comment_params
    params.require(:g_comment).permit( :gallary_id, :title, :comment)
  end
end
