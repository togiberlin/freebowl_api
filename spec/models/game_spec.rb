require 'rails_helper'

RSpec.describe Game do
  # Association tests
  it { should have_many(:players).dependent(:destroy) }
  it { should have_many(:frames).through(:players) }

  # Validation tests
  it { should validate_presence_of(:created_by) }
  it { should validate_length_of(:created_by).is_at_most(50) }
end
