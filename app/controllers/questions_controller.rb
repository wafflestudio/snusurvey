class QuestionsController < ApplicationController
  before_filter :check_signin, :only => [:new]

  def new
    @question = Question.new
    @survey = Survey.find(params[:survey_id])
    @question_template = QuestionTemplate.where(:type => params[:question_template_type]).first
  end

  def update
    @question = Question.find(params[:id])
    params[:question][:examples] = params[:question][:examples].map {|key, value| Example.new(value, :question_id => @question._id)} + @question.examples
    if @question.update_attributes(params[:question])
        redirect_to survey_path(@question.survey)
    else
        logger.info @question.errors.full_messages
        render 'survey/show'
    end
  end

end
