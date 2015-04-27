class QueuesController < ApplicationController

  def dashboard
    enqueued = Aircraft.all
    @num_current_cargo = enqueued.where(kind: "cargo").count
    @num_current_passenger = enqueued.where(kind: "passenger").count 
    @num_current_small = enqueued.where(size: "small").count 
    @num_current_large = enqueued.where(size: "large").count
    @aircraft_count = enqueued.count
    
  end

  def new
    @aircraft = Aircraft.new
    @size_options = Aircraft.size_options
    @type_options = Aircraft.type_options

  end

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
      flash[:alert] = "#{e} Unable to dequeue aircraft."
    end
    redirect_to :back
  end

private
  def enqueue_params
    params.permit("kind", "size")
  end

end