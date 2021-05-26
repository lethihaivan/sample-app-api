class Api::V1::SessionsController < ApplicationController
  skip_before_action :authenticate  , only: :create
  before_action :set_user, only: %i(ensure_params_exist create)

  def create
    if @user.authenticate(sign_in_params[:password])
      @user.auth_token = Auth.issue({user: @user.id})
      render json: @user, serializer: UserSerializer
    else
      render_invalid
    end
  end

  def destroy
    current_user.destroy_token
    render json: {messages: I18n.t("sessions.signed_out")}, status: :ok
  end
  private

  def ensure_params_exist
    return if params[:sign_in].present?

    render json: {messages: I18n.t("sessions.missing_params")},
      status: :bad_request
  end

  def render_invalid
    render json: {messages: I18n.t("sessions.invalid")}, status: :unauthorized
  end

  def sign_in_params
    params.require(:sign_in).permit :email, :password
  end

  def set_user
    return if ensure_params_exist

    @user = User.find_by email: sign_in_params[:email]
    return if @user

    render_invalid
  end
end
