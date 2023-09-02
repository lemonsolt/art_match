class Artist::ChatThreadController < ApplicationController
  before_action :sign_in_user
  
  def index
    @chat_threads = ChatThread.order(created_at: :DESC).page(params[:page]).per(20)
    @new_chat_thread = ChatThread.new
  end
  
  def create
    @chat_thread = ChatThread.new(thread_params)
    @chat_comment = ChatComment.new
    # chat_comment=params[:chat_thread][:comment]
    
    set_comment_attributes
    @chat_comment.thread_id = @chat_thread.id
    
    ChatThread.transaction do
      if @chat_thread.save
        @chat_comment.save(comment_params)
        redirect_to chat_thread_path(@chat_thread),notice: 'スレッドを建てました。'
      else
        flash[:alert] = "スレッドを建てられませんでした。"
        redirect_to chat_thread_index_path
      end
    # レスキュー処理文章
    rescue ActiveRecord::RecordInvalid => exception
      flash[:alert] = 'スレッドを建てられませんでした。'
      redirect_to chat_thread_index_path
    end
  end
  
  def show
    @chat_thread = ChatThread.find(params[:id])
    @chat_comments = chat_thread.chat_comments.page(params[:page]).per(50)
    @chat_comment = ChatComment.new
  end
  
  def destroy
    @chat_thread = ChatThread.find(params[:id])
    @chat_thread.destroy
    redirect_to chat_thread_index_path
  end
  
  def comment_create
    @chat_thread = ChatThread.find(params[:id])
    @chat_comment = ChatComment.new(comment_params)
    set_comment_attributes
    @chat_comment.thread_id = @chat_thread.id
    if @chat_comment.save
      redirect_to chat_thread_path(@chat_thread),notice: 'コメントを送信しました。'
    else
      flash[:alert] = "コメント送信できませんでした。"
      redirect_to chat_thread_path(@chat_thread)
    end
  end
  
  protected
  
  def thread_params
    params.require(:chat_thread).permit( :title)
  end
  
  def comment_params
    params.require(:chat_comment).permit( :thread_id, :artist_id, :gallary_id, :comment)
  end
  
  def set_comment_attributes
    if artist_signed_in?
      @chat_comment.artist_id = current_artist.id
      @chat_comment.gallary_id = nil
    elsif gallery_signed_in?
      @chat_comment.gallary_id = current_gallary.id
      @chat_comment.artist_id = nil
    end
  end
  
  def sign_in_user
    unless artist_signed_in? || gallary_signed_in?
      redirect_to root_path, alert: "ログインしてください"
    end
  end
  
end
