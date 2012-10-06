class ExamplesController < ApplicationController
    def new
        @example = Example.new
        @question = Question.find(params[:question_id])
        @question_template = @question.question_template
    end
end
