class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :authenticate_user!


private

  rescue_from StandardError do |e|
    flash[:alert] = "Oops! Something went wrong. Please try again."
    redirect_to :root
  end
  
end
