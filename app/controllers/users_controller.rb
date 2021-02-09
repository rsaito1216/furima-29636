class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
      if @user.valid?
        @user.save
        redirect_to action: :index
      else
        render action: :new
      end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user = User.find(params[:id])
       @user.update(user_params)
         redirect_to root_path
    else
      render action: :edit
    end
  end

  def show
    user = User.find(params[:id])
    @user = User.find(params[:id])
    @nickname = user.nickname
    @user_items = user.items
    @user_favorites = current_user.favorite_items
  
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :encripted_password, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_date)
  end
end