require 'rails_helper'

RSpec.describe QueuesController, type: :controller do

  before :each do
    100.times do
      FactoryGirl.create :aircraft
    end
  end


  it 'can remove aircraft from the system' do

    # u1 = FactoryGirl.create :user
    # login u1
    expect(Aircraft.count).to eq 100

    delete :dequeue

    expect(Aircraft.count).to eq 99
  end

  it 'can add aircraft to the system'

  it 'handles errors gracefully'
end