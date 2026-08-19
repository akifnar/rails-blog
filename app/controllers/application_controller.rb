class ApplicationController < ActionController::Base
  include SessionsHelper


  allow_browser versions: :modern
  def hello
   render html: "Hiii"
  end

  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url, status: :see_other
    end
  end
end
