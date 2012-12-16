class SessionsController < ApplicationController
  before_filter :get_key, :only => [:oauth, :facebook]
  def new
  end
  def create
    user = User.authenticate(params[:sessions][:name], params[:sessions][:password])
    if user.nil?
      render "new"
    else
      if user.auth
        sign_in user
        redirect_to root_path
      else
        flash[:return] = false
        redirect_to signup_path
      end
    end
  end

  def oauth
    session[:access_token] = @oauth.get_access_token(params[:code]) if params[:code]
    graph = Koala::Facebook::API.new(session[:access_token])
    me = graph.get_object("me")
    id = me['id']

    user = User.find_or_create_by(:fbid => id)
    unless user.nil?
      sign_in user
    end
    session[:access_token] = nil
    
    redirect_to root_path
  end

  def facebook
    redirect_to @oauth.url_for_oauth_code()
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private
  def get_key
    @app_id = Facebook::APP_ID
    @secret = Facebook::SECRET
    @callback = Facebook::CALLBACK
    @oauth = Koala::Facebook::OAuth.new(@app_id, @secret, @callback)
  end
end
