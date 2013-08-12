class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def check_session
    (session[:redirect_path] = request.fullpath; redirect_to "/") if session[:user].nil? 
  end

  def index
    if session[:user]
      redirect_to meetings_path
    end
  end
end
