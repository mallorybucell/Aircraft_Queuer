require 'rails_helper'

RSpec.describe Aircraft, type: :model do

#Dequeing specs

  it 'only dequeues cargo planes when there are no available passenger planes' do
    2.times do
      FactoryGirl.create :aircraft, kind: "cargo"
    end
    FactoryGirl.create :aircraft, kind: "passenger"
    FactoryGirl.create :aircraft, kind: "cargo"

    expect(Aircraft.count).to eq 4
    expect(Aircraft.where(kind: "cargo").count).to eq 3
    expect(Aircraft.where(kind: "passenger").count).to eq 1

    Aircraft.dequeue_aircraft!

    expect(Aircraft.count).to eq 3
    expect(Aircraft.where(kind: "cargo").count).to eq 3
    expect(Aircraft.where(kind: "passenger").count).to eq 0

    Aircraft.dequeue_aircraft!

    expect(Aircraft.count).to eq 2
    expect(Aircraft.where(kind: "cargo").count).to eq 2
  end

  it 'only dequeues small planes when there are no available large planes of the same type' do
    2.times do
      FactoryGirl.create :aircraft, kind: "cargo", size: "small"
    end
    FactoryGirl.create :aircraft, kind: "cargo", size: "large"
    FactoryGirl.create :aircraft, kind: "cargo", size: "small"

    expect(Aircraft.count).to eq 4
    expect(Aircraft.where(size: "small").count).to eq 3
    expect(Aircraft.where(size: "large").count).to eq 1

    Aircraft.dequeue_aircraft!

    expect(Aircraft.count).to eq 3
    expect(Aircraft.where(size: "small").count).to eq 3
    expect(Aircraft.where(size: "large").count).to eq 0

    Aircraft.dequeue_aircraft!

    expect(Aircraft.count).to eq 2
    expect(Aircraft.where(size: "small").count).to eq 2
    expect(Aircraft.where(size: "large").count).to eq 0
  end

  it 'dequeues aircraft of the same size and type that have been queued longest first' do
    #Passenger planes
    100.times do
      FactoryGirl.create :aircraft, size: "large", kind: "passenger"
    end
    oldest = Aircraft.first

    expect(Aircraft.count).to eq 100
    expect(Aircraft.all.pluck(:id)).to include(oldest.id)

    Aircraft.dequeue_aircraft!

    expect(Aircraft.count).to eq 99
    expect(Aircraft.all.pluck(:id)).to_not include(oldest.id)
  end

  it 'removes a small passenger plane over a large cargo plane' do
    FactoryGirl.create :aircraft, size: "large", kind: "cargo"
    FactoryGirl.create :aircraft, size: "small", kind: "passenger"

    Aircraft.dequeue_aircraft!

    expect(Aircraft.count).to eq 1
    expect(Aircraft.first.kind).to eq "cargo"

    #reverse added-to-queue order
    Aircraft.delete_all

    FactoryGirl.create :aircraft, size: "small", kind: "passenger"
    FactoryGirl.create :aircraft, size: "large", kind: "cargo"

    Aircraft.dequeue_aircraft!

    expect(Aircraft.count).to eq 1
    expect(Aircraft.first.kind).to eq "cargo"   
  end

  it 'removes a more-recently queued passenger plane over an earlier-queued cargo plane' do
    FactoryGirl.create :aircraft, size: "large", kind: "cargo"
    FactoryGirl.create :aircraft, size: "large", kind: "passenger"

    Aircraft.dequeue_aircraft!

    expect(Aircraft.count).to eq 1
    expect(Aircraft.first.kind).to eq "cargo"   
  end

  it 'removes a more-recently queued large plane over an earlier-queued small plane of the same type' do
    FactoryGirl.create :aircraft, size: "small", kind: "cargo"
    FactoryGirl.create :aircraft, size: "large", kind: "cargo"

    Aircraft.dequeue_aircraft!

    expect(Aircraft.count).to eq 1
    expect(Aircraft.first.size).to eq "small"   
  end

  it 'handles large amounts of aircraft' do
    100.times do
      FactoryGirl.create :aircraft
    end

    earliest_large_passenger_ac = Aircraft.where(kind: "passenger", size: "large").order(created_at: :asc).first

    expect(Aircraft.count).to eq 100
    expect(Aircraft.pluck(:id)).to include(earliest_large_passenger_ac.id)

    Aircraft.dequeue_aircraft!

    expect(Aircraft.count).to eq 99
    expect(Aircraft.pluck(:id)).to_not include(earliest_large_passenger_ac.id)
  end

#Enqueing specs

  it 'requires kind and size when adding a new plane to the system' do
    5.times do
      FactoryGirl.create :aircraft
    end

    expect(Aircraft.count).to eq 5

    expect do
      Aircraft.create!(size: "large")
    end.to raise_error ActiveRecord::RecordInvalid
    expect(Aircraft.count).to eq 5

    expect do
      Aircraft.create!(kind: "passenger")
    end.to raise_error ActiveRecord::RecordInvalid
    expect(Aircraft.count).to eq 5

    Aircraft.create!(size: "large", kind: "passenger")
    expect(Aircraft.count).to eq 6
  end

end
