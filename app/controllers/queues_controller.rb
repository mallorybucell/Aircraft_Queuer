class QueuesController < ApplicationController

  def dequeue
    begin
      if Aircraft.dequeue_aircraft!
       flash[:notice] = "Aircraft dequeued successfully!"
      end
    rescue Aircraft::UnavailableError => e
      flash[:alert] = "#{e} Unable to dequeue aircraft. Please try again."
    end
    redirect_to :back
  end
end