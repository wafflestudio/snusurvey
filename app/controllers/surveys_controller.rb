class SurveysController < ApplicationController
  before_filter :check_signin, :only => [:new, :create, :show, :question, :update]
  before_filter :auth_me, :only => [:show, :question, :update]

  def new
    @survey = Survey.new
    @survey_templates = SurveyTemplate.all.map {|st| [st.title, st._id]}
    @result_templates = ResultTemplate.all.map {|rt| [rt.title, rt._id]}
  end

  def create
    @survey = Survey.new(params[:survey])
    @survey.admin = current_user
    if @survey.save
      redirect_to survey_path(@survey)
    else
      render "new"
    end
  end

  def show
    @survey = Survey.find(params[:id])
  end

  def question
    @survey = Survey.find(params[:id])
  end

  def update
    @survey =  Survey.find(params[:id])
    params[:survey][:questions] = params[:survey][:questions].map {|key, value| Question.new(value, :survey_id => @survey._id)}
    if @survey.update_attributes(params[:survey])
      redirect_to survey_path(@survey)
    else
      render "question"
    end
  end

  private
  def auth_me
    @survey = Survey.find(params[:id])
    if @survey.admin == current_user
    else
      redirect_to signin_path
    end
  end
end