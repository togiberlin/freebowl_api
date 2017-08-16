require 'rails_helper'

RSpec.describe Player do
  # Association tests
  it { is_expected.to belong_to(:game) }
  it { is_expected.to have_many(:frames).dependent(:destroy) }

  # Validation tests
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_most(50) }
end
