# frozen_string_literal: true

class Gallary::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_gallary, only: [:create]

  def guest_sign_in
    gallary = Gallary.guest
    sign_in gallary
    redirect_to root_path, notice: 'ゲストギャラリーとしてログインしました'
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

  def reject_gallary
    @gallary= Gallary.find_by(email: params[:gallary][:email])
    if @gallary
      if @gallary.valid_password?(params[:gallary][:password]) && (@gallary.is_cold == true)
        flash[:alert] = "このアカウントは凍結されています。"
        redirect_to new_gallary_session_path
      else

      end
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
