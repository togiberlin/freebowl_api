require 'rails_helper'

RSpec.describe Player do
  # Association tests
  it { should have_many(:frames).dependent(:destroy) }

  # Validation tests
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_most(50) }
end
