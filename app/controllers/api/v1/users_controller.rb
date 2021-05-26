class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i(show update destroy)

  def index
    @users = User.newest.page params[:page]

    render json: @users, each_serializer: UserSerializer
  end

  def show
    render json: @user, serializer: UserSerializer
  end

  def create
    @user = User.new user_params
    return handle_response @user, :created  if @user.save
      
    handle_response @user.errors,  :unprocessable_entity
   end

  def update
    return render json: @user, status: :ok if @user.update user_params

    render json: @user.errors, status: :unprocessable_entity
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private
  def set_user
    @user = User.find_by(id: params[:id])

    return if @user
    render json: {}, status: :not_found
  end

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def handle_response data, status
    render json: data, status: status
  end
end
