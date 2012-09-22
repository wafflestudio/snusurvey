class PapersController < ApplicationController
  def show
    @paper = Paper.find(params[:id])
    @survey = @paper.survey
  end
end
