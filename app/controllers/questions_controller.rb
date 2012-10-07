class QuestionsController < ApplicationController
  before_filter :check_signin, :only => [:new, :destroy]
  before_filter :auth_me, :only => [:destroy]

  def new
    @question = Question.new(:question_template_id => params[:question_template_id], :survey_id => params[:survey_id])
    if @question.save
    else
      render "main/failure"
    end
  end

  def destroy
    @question.destroy
  end

  private
  def auth_me
    @question = Question.find(params[:id])
    if @question.survey.admin == current_user
    else
      redirect_to signin_path
    end
  end
end
