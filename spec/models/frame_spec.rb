require 'rails_helper'

RSpec.describe Frame do
  subject { create(:frame) }
  # Association test
  it { should belong_to(:player) }

  # Validation tests
  it { should validate_numericality_of(:ball_one_pins).only_integer }
  it { should validate_numericality_of(:ball_two_pins).only_integer }
  it { should validate_numericality_of(:ball_three_pins).only_integer }
  it { should validate_numericality_of(:score).only_integer }
  it { should validate_numericality_of(:ball_one_pins).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:ball_two_pins).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:ball_three_pins).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:ball_one_pins).is_less_than_or_equal_to(10) }
  it { should validate_numericality_of(:ball_two_pins).is_less_than_or_equal_to(10) }
  it { should validate_numericality_of(:ball_three_pins).is_less_than_or_equal_to(10) }
  it { should validate_numericality_of(:score).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:score).is_less_than_or_equal_to(300) }

  # Custom validation tests
  describe 'frame_cannot_be_added_when_game_finished' do
    let(:eleventh_frame) { FactoryGirl.build :frame, :invalid_eleventh_frame }
    let(:error_message) { I18n.t('activerecord.errors.models.frame.attributes.frame_number.game_over') }

    it 'makes sure that the 11th frame cannot be created' do
      expect(eleventh_frame).to be_invalid
      expect(eleventh_frame.errors[:frame_number]).to include(error_message)
    end

    context 'when the current frame is not the last frame' do
      let(:valid_frame) { FactoryGirl.build :frame, :not_last_frame }

      it 'allows creating a new frame' do
        expect(valid_frame).to be_valid
        expect(valid_frame.errors[:frame_number]).to be_empty
      end
    end
  end

  describe 'dropped_pins_cannot_be_higher_than_ten' do
    let(:frame) { FactoryGirl.build :frame, :invalid_partial_score }
    let(:error_message) { I18n.t('activerecord.errors.models.frame.attributes.partial_score.impossible_values') }

    it 'makes sure that not more than 10 pins can be dropped per frame' do
      expect(frame).to be_invalid
      expect(frame.errors[:partial_score]).to include(error_message)
    end

    context 'when the dropped pins per frame are lower than ten' do
      let(:frame) { FactoryGirl.build :frame, :normal }

      it 'allows creating a new frame' do
        expect(frame).to be_valid
        expect(frame.errors[:partial_score]).to be_empty
      end
    end
  end

  describe 'third_throw_not_yet_allowed' do
    let(:frame) { FactoryGirl.build :frame, :invalid_third_throw }
    let(:error_message) { I18n.t('activerecord.errors.models.frame.attributes.ball_three_pins.not_yet_allowed') }

    it 'makes sure that a third throw is not allowed for frames 1 to 9' do
      expect(frame).to be_invalid
      expect(frame.errors[:ball_three_pins]).to include(error_message)
    end

    context 'when the last frame is a strike' do
      let(:frame) { FactoryGirl.build :frame, :last_frame_with_strike }

      it 'allows a third throw' do
        expect(frame).to be_valid
        expect(frame.errors[:ball_three_pins]).to be_empty
        expect(frame.partial_score).to be_between(10,30)
      end
    end

    context 'when the last frame is a spare' do
      let(:frame) { FactoryGirl.build :frame, :last_frame_with_spare }

      it 'allows a third throw' do
        expect(frame).to be_valid
        expect(frame.errors[:ball_three_pins]).to be_empty
        expect(frame.partial_score).to be_between(10,20)
      end
    end
  end

  # Callback test
  it { should callback(:update_score).after(:save) }

  # Scoping test
  describe 'default_scope' do
    let!(:frame_one) { FactoryGirl.create :frame }
    let!(:frame_two) { FactoryGirl.create :frame }
    let(:ordered_frame_numbers) { Frame.all.map(&:frame_number) }

    it 'orders by ascending frame_number attribute' do
      expect(ordered_frame_numbers).to eq [frame_one.frame_number, frame_two.frame_number]
    end
  end

  # Instance method tests
  describe '#strike?' do
    let(:frame) { FactoryGirl.build :frame, :strike }

    it 'recognizes a strike' do
      expect(frame.strike?).to be_truthy
    end

    context 'when the evaluated frame is not a strike' do
      let(:frame) { FactoryGirl.build :frame, :normal }

      it 'returns false' do
        expect(frame.strike?).to be_falsey
      end
    end
  end

  describe '#spare?' do
    let(:frame) { FactoryGirl.build :frame, :spare }

    it 'recognizes a spare' do
      expect(frame.spare?).to be_truthy
    end

    context 'when the evaluated frame is not a spare' do
      let(:frame) { FactoryGirl.build :frame, :normal }

      it 'returns false' do
        expect(frame.spare?).to be_falsey
      end
    end
  end

  describe '#last?' do
    let(:frame) { FactoryGirl.build :frame, :last_frame }

    it 'recognizes the last frame' do
      expect(frame.last?).to be_truthy
    end

    context 'when it is not the last frame' do
      let(:frame) { FactoryGirl.build :frame, :normal }

      it 'returns false' do
        expect(frame.last?).to be_falsey
      end
    end
  end

  describe '#partial_score' do
    let(:frame) { FactoryGirl.build :frame, :normal }
    let(:partial_score) { frame.ball_one_pins + frame.ball_two_pins + frame.ball_three_pins }

    it 'calculates the partial score correctly' do
      expect(frame.partial_score).to eq(partial_score)
    end
  end
end
