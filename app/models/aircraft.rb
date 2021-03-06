class Aircraft < ActiveRecord::Base
  class UnavailableError < StandardError; end

  validates_presence_of :size, :kind
  validates :size, inclusion: { in: %w(small large),
    message: "%{value} is not a valid size." }
  validates :kind, inclusion: { in: %w(passenger cargo),
    message: "%{value} is not a valid aircraft type." }


  def self.enqueue!(options)
    Aircraft.create!(size: options["size"], kind: options["kind"])
  end

  def self.grab_removable_aircraft
    unless aircraft = Aircraft.passenger_ac_available_to_remove? || aircraft = Aircraft.cargo_ac_available_to_remove?
      raise Aircraft::UnavailableError, "There are no aircraft currently queued."
    end
    aircraft
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

  def self.size_options
    ["small", "large"]
  end

  def self.type_options
    ["passenger", "cargo"]
  end

  def self.passenger_ac_available_to_remove?
    available = Aircraft.where(kind: "passenger")
    available if available != []
  end

  def self.cargo_ac_available_to_remove?
    available = Aircraft.where(kind: "cargo")
    available if available != []
  end

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
