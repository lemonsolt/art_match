class Admin::ACommentsController < ApplicationController
  before_action :authenticate_admin!,{only:[:index, :show, :destroy]}

  def index
    @comments = AComment.order(created_at: :DESC).page(params[:page]).per(20)
  end

  def show
    @comment = AComment.find(params[:id])
  end

  def destroy
    @comment = AComment.find(params[:id])
    @comment.destroy
    redirect_to admin_a_comments_path
  end
end
