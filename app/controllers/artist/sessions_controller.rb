# frozen_string_literal: true

class Artist::SessionsController < Devise::SessionsController
  before_action :reject_artist, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  def guest_sign_in
    artist = Artist.guest
    sign_in artist
    redirect_to root_path, notice: 'ゲストアーティストとしてログインしました'
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end


  protected

  def reject_artist
    @artist= Artist.find_by(email: params[:artist][:email])
    if @artist
      if @artist.valid_password?(params[:artist][:password]) && (@artist.is_cold == true)
        flash[:alert] = "このアカウントは凍結されています。"
        redirect_to new_artist_session_path
      else

      end
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
