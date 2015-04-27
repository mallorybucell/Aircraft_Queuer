class QueuesController < ApplicationController

  def enqueue
    if Aircraft.enqueue!(enqueue_params)
      flash[:notice] = "Aircraft enqueued successfully."
    else
      flash[:alert] = "Could not add aircraft. Please try again."
    end
    redirect_to :root
  end

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

private
  def enqueue_params
    params.permit("kind", "size")
  end

end