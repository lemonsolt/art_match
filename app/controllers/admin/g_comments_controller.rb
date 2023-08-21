class Admin::GCommentsController < ApplicationController
  before_action :authenticate_admin!,{only:[:index, :show, :destroy]}

  def index
    @comments = GComment.page(params[:page]).per(20)
  end

  def show
    @comment = GComment.find(params[:id])
  end

  def destroy
    @comment = GComment.find(params[:id])
    @comment.destroy
    redirect_to admin_g_comments_path
  end
end
