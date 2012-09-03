class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def back
    request.env["HTTP_REFERER"] || "/"
  end

  def check_signin
    unless signed_in?
      redirect_to signin_path
    end
  end
end
