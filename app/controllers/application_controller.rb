class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def home
  end

private

  rescue_from StandardError do |e|
    flash[:alert] = "Oops! Something went wrong. Please try again."
    redirect_to :root
  end
  
end
