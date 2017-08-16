require 'rails_helper'

RSpec.describe Game do
  # Association tests
  it { is_expected.to have_many(:players).dependent(:destroy) }
  it { is_expected.to have_many(:frames).through(:players) }

  # Validation tests
  it { is_expected.to validate_presence_of(:created_by) }
  it { is_expected.to validate_length_of(:created_by).is_at_most(50) }
end
