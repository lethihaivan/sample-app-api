require "./lib/auth.rb"
class ApplicationController < ActionController::API
  before_action :authenticate

  def logged_in?
    current_user.present?
  end

  def current_user
    if auth_present? && auth
      user = User.find_by(id: auth["user"])
      if user
        @current_user ||= user
      end
    end
  end

  def authenticate
    render json: {error: "unauthorized"}, status: 401  unless logged_in?
  end

  private
  def token
    request.headers["Authorization"].scan(/Bearer (.*)$/).flatten.last
  end

  def auth
    Auth.decode(token)
  rescue JWT::DecodeError, JWT::VerificationError
    false
  end

  def auth_present?
    request.headers.fetch("Authorization", "").scan(/Bearer/).flatten.first
  end
end