class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
    else
      flash[:error] = "회원가입 실패"
    end
  end
end
