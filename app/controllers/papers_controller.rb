class PapersController < ApplicationController
  before_filter :check_signin
  before_filter :auth_me, :only => [:show, :complete, :result, :destroy, :update]

  def show
    @survey = @paper.survey
  end

  def complete
    if @paper.completed || @paper.update_attribute(:completed, true)
      redirect_to result_paper_path(@paper)
    else
      redirect_to paper_path(@paper)
    end
  end

  def update
  end

  def result
    if @paper.completed
    else
      redirect_to paper_path(@paper)
    end
  end

  def destroy
    @paper.destroy
    redirect_to root_path
  end

  def me
    @papers = current_user.papers
  end

  private
  def auth_me
    @paper = Paper.find(params[:id])
    if @paper.user == nil || signed_in? && @paper.user == current_user
    else
      redirect_to signin_path
    end
  end
end
