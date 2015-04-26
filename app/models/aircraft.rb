class Aircraft < ActiveRecord::Base

  def self.removable_aircraft
    Aircraft.where(kind: "passenger") || Aircraft.where(kind: "cargo")
  end

  def self.sort_removable_aircraft_by_size
    dequeable = Aircraft.removable_aircraft
    dequeable.where(size: "large") || dequeable.where(size: "small")
  end

  def self.sort_removable_aircraft_by_date_queued
    Aircraft.sort_removable_aircraft_by_size.order(created_at: :asc).first
  end

  def self.dequeue_aircraft!
    dequeued_ac = Aircraft.sort_removable_aircraft_by_date_queued
    Aircraft.delete(dequeued_ac.id)
  end


end
