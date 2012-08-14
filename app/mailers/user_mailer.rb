class UserMailer < ActionMailer::Base
  default from: "auth@snusurvey.com"

  def send_auth_key(user)
    @user = user
    mail(:to => "#{user.name}@snu.ac.kr", :subject => "none") do |format|
      format.html
    end
  end
end
