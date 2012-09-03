class QuestionsController < ApplicationController
  before_filter :check_signin, :only => [:new]

  def new
    @question = Question.new
    @survey = Survey.find(params[:survey_id])
    @question_template = QuestionTemplate.where(:type => params[:question_template_type]).first
  end
end
