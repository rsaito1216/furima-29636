class UsersController < ApplicationController
  def index
  end

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

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :encripted_password, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_date)
  end
end