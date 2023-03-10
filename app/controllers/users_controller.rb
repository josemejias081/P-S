class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]


  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
    if @user.save 
      #WelcomeMailer.notify(@user).deliver_now!
      flash[:success] = "Usuario creado exitosamente"
      redirect_to users_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, status: :see_other
  end

  def reset_password
    @user = User.find(params[:user_id])
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:id, :name, :email, :role, :status, :address, :phone, :active, :password, :password_confirmation)
    end
end

