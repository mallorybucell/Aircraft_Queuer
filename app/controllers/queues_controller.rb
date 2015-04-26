class QueuesController < ApplicationController

  def dequeue
    if Aircraft.dequeue_aircraft!
      flash[:notice] = "Aircraft dequeued successfully!"
      redirect_to :root
    else
      flash[:alert] = "Unable to dequeue aircraft. Please try again."
      redirect_to :back
    end
  end
end