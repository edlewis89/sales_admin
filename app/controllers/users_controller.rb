class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:notice] = "Welcome!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def import
    if params[:file].nil?
      render 'index', notice: "No file to Import!!"
    else
      if logged_in?
        #get current user
        @user = User.find(session[:user_id])
        User.import(params[:file])

        redirect_to user_path(@user), notice: "Successful Import!!"
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password,
                                 :password_confirmation)
  end
end
