class QueuesController < ApplicationController

  def dequeue
    if Aircraft.dequeue_aircraft!
      flash[:notice] = "Aircraft dequeued successfully!"
  end
end