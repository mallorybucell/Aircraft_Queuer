class Aircraft < ActiveRecord::Base

  def self.grab_removable_aircraft
    #FIXME error if no planes available
    removable = Aircraft.where(kind: "passenger")
    if removable == []
      Aircraft.where(kind: "cargo")
    else 
      removable
    end
  end

  def self.grab_removable_aircraft_by_size
    Aircraft.large_available_to_remove? || Aircraft.small_available_to_remove?
  end

  def self.grab_removable_aircraft_by_date_queued
    Aircraft.grab_removable_aircraft_by_size.order(created_at: :asc).first
  end

  def self.dequeue_aircraft!
    dequeued_ac = Aircraft.grab_removable_aircraft_by_date_queued
    Aircraft.delete(dequeued_ac.id)
  end

private
  def self.large_available_to_remove?
    dequeable = Aircraft.grab_removable_aircraft
    available = dequeable.where(size: "large") if dequeable.where(size: "large") != []
    available
  end

  def self.small_available_to_remove?
    dequeable = Aircraft.grab_removable_aircraft
    available = dequeable.where(size: "small") if dequeable.where(size: "small") != []
    available
  end


end
