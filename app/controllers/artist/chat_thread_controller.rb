class Artist::ChatThreadController < ApplicationController
  before_action :sign_in_user
  before_action :ensure_guest_gallary,{only: [:show]}
  before_action :ensure_guest_artist,{only: [:show]}

  def index
    @chat_threads = ChatThread.order(created_at: :DESC).page(params[:page]).per(20)
    @new_chat_thread = ChatThread.new
    @new_chat_thread.chat_comments.build
  end

  def create
    @chat_thread = ChatThread.new(thread_params)

    # set_comment_attributes

    ChatThread.transaction do
      if @chat_thread.save
        redirect_to chat_thread_path(@chat_thread), notice: 'スレッドを建てました。'
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
    @chat_comments = @chat_thread.chat_comments.page(params[:page]).per(50)
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
    # set_comment_attributes
    @chat_comment.chat_thread_id = @chat_thread.id
    if @chat_comment.save
      redirect_to chat_thread_path(@chat_thread),notice: 'コメントを送信しました。'
    else
      flash[:alert] = "コメント送信できませんでした。"
      redirect_to chat_thread_path(@chat_thread)
    end
  end

  protected

  def thread_params
    params.require(:chat_thread).permit( :title, chat_comments_attributes: [:artist_id, :gallary_id, :chat_thread_id, :comment])
  end

  def comment_params
    params.require(:chat_comment).permit( :chat_thread_id, :artist_id, :gallary_id, :comment)
  end

  # def set_comment_attributes
  #   if artist_signed_in?
  #     @new_chat_comment.artist_id = current_artist
  #     @new_chat_comment.gallary_id = nil
  #   elsif gallery_signed_in?
  #     @new_chat_comment.gallary_id = current_gallary
  #     @new_chat_comment.artist_id = nil
  #   end
  # end

  def ensure_guest_gallary
    if gallary_signed_in? && current_gallary.email == "guest@example.com"
      redirect_to gallary_path(current_gallary), alert: "ゲストギャラリーはDM画面へ遷移できません。"
    end
  end
  def ensure_guest_artist
    if artist_signed_in? && current_artist.email == "guest@example.com"
      redirect_to gallary_path(current_artist), alert: "ゲストアーティストはDM画面へ遷移できません。"
    end
  end

  def sign_in_user
    unless artist_signed_in? || gallary_signed_in? || admin_signed_in?
      redirect_to root_path, alert: "ログインしてください"
    end
  end

end
