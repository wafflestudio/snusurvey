class SurveysController < ApplicationController
  before_filter :check_signin, :only => [:new, :create, :show, :update, :reply, :edit, :destroy, :me]
  before_filter :auth_me, :only => [:show, :update, :edit, :destroy]

  def new
    @survey = Survey.new
    @survey_templates = SurveyTemplate.all.map {|st| [st.title, st._id]}
    @result_templates = ResultTemplate.all.map {|rt| [rt.title, rt._id]}
  end

  def create
    @survey = Survey.new(params[:survey])
    @survey.admin = current_user
    if @survey.save
      redirect_to edit_survey_path(@survey)
    else
      render "new"
    end
  end

  def show
    @survey = Survey.find(params[:id])
  end

  def result
    @survey = Survey.find(params[:id])
  end

  def update
    @survey =  Survey.find(params[:id])
    unless params[:survey][:questions].nil?
      params[:survey][:questions] = params[:survey][:questions].map {|key, value| 
        question = Question.find(key)
        unless value[:examples].nil?
          value[:examples] = value[:examples].map {|key, value|
            example = Example.find(key)
            example.update_attributes(value)
            example
          }
        end
        question.update_attributes(value)
        question
      }
    end
    if @survey.update_attributes(params[:survey])
      redirect_to survey_path(@survey)
    else
      render "edit"
    end
  end

  def edit
    @survey = Survey.find(params[:id])
    @survey_templates = SurveyTemplate.all.map {|st| [st.title, st._id]}
    @result_templates = ResultTemplate.all.map {|rt| [rt.title, rt._id]}
    @question_templates = QuestionTemplate.all.map {|qt| [qt.title, qt._id]}
  end

  def enter
    @survey = Survey.find(params[:id])
    paper = @survey.generate_paper(current_user)
    if paper.nil?
      redirect_to back
    else
      redirect_to paper_path(paper)
    end
  end

  def destroy
    @survey.destroy
    redirect_to root_path
  end

  def me
    @surveys = current_user.surveys
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
