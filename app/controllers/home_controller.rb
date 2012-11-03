class HomeController < ApplicationController
  def index
    @schools = School.all
    render :layout => 'home'
  end
  def signin
   scope = 'http://www.google.com/calendar/feeds/'
    next_url = 'localhost:3000'
    secure = false  # set secure = true for signed AuthSub requests
    sess = true
    authsub_link = GData::Auth::AuthSub.get_url(next_url, scope, secure, sess)
    redirect_to authsub_link
  end
end
