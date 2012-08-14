class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(:name => params[:user][:name])
    if @user.save
      @user.send_auth_key
    else
      flash[:error] = "회원가입 실패"
    end
  end
end
