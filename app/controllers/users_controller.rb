class UsersController < ApplicationController
  protect_from_forgery except: :search # searchアクションを除外
  before_action :authenticate_user,{only:[:index, :edit, :update]}

  def new
    if params[:back]
      @user = User.new(user_params)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render new_user_path
    end
  end

  def show
    @user = User.find(params[:id])
    @favorites_blogs = @user.favorites
  end


  def confirm
    @user = User.new(user_params)
  end

  # GET /feeds/1/edit
  def edit
  end

  def update
  end

  def likes
    @user = current_user
    @favorites_blogs = @user.favorites
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    @user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :image_cache)
  end

end
