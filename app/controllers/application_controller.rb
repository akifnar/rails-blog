class ApplicationController < ActionController::Base
  include SessionsHelper

  allow_browser versions: :modern
  def hello
   render html: "Hiii"
  end
end
