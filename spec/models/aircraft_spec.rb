require 'rails_helper'

RSpec.describe Aircraft, type: :model do
  
  it 'prefers passenger aircraft over cargo aircraft when dequeing'

  it 'prefers large aircraft over small aircraft when dequeing'

  it 'dequeues aircraft that have been queued longest first'

  it 'only dequeues cargo planes when there are no available passenger planes'

  it 'only dequeues small planes when there are no available large planes'

  it 'removes a small passenger plane over a large cargo plane'

  it 'removes a newer passenger plane over an older cargo plane'

  it 'removes a newer large plane over an older small plane'

  it 'requires kind and size when adding a new plane to the system'

end
