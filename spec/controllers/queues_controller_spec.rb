require 'rails_helper'

RSpec.describe QueuesController, type: :controller do

  before :each do
    u1 = FactoryGirl.create :user
    login u1
  end


  it 'can remove aircraft from the system' do
    100.times do
      FactoryGirl.create :aircraft
    end

    expect(Aircraft.count).to eq 100

    delete :dequeue

    expect(Aircraft.count).to eq 99
    expect(response.code).to eq 302.to_s
  end

  # it 'can add aircraft to the system'
  #   100.times do
  #     FactoryGirl.create :aircraft
  #   end

  it 'handles errors gracefully' do
    expect(Aircraft.count).to eq 0

    delete :dequeue

    expect(response.code).to eq "302"
  end
end