class ExamplesController < ApplicationController
  before_filter :check_signin, :only => [:new, :destroy]
  before_filter :auth_me, :only => [:destroy]

  def new
    @example = Example.new(:question_id => params[:question_id])
    if @example.question.survey.admin == current_user && @example.save
    else
      render "main/failure"
    end
  end

  def destroy
    @example.destroy
  end

  private
  def auth_me
    @example = Example.find(params[:id])
    if @example.question.survey.admin == current_user
    else
      redirect_to signin_path
    end
  end
end
