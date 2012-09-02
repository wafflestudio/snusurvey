# encoding: utf-8
class FeedbacksController < ApplicationController
  def index
    @feedbacks = Feedback.all
    @feedback = Feedback.new
  end

  def create
    if signed_in?
      feedback = Feedback.new(:content => params[:feedback][:content], :user => current_user)
    else
      feedback = Feedback.new(:content => params[:feedback][:content], :password => Feedback.encrypt_password(params[:feedback][:password]))
    end

    if feedback.save
      flash[:error] = false
      flash[:msg] = "성공"
    else
      flash[:error] = true
      flash[:msg] = "실패"
    end
  end

  def destroy
    feedback = Feedback.find(params[:id])
    if (signed_in? && feedback.user?(current_user) || feedback.password == Feedback.encrypt_password(params[:feedback])) && feedback.destroy
      flash[:error] = false
      flash[:msg] = "성공"
    else
      flash[:error] = true
      flash[:msg] = "실패"
    end
  end
end
