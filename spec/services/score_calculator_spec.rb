require 'rails_helper'

RSpec.describe ScoreCalculator do
  describe '#call!' do
    let(:frames) { [instance_double(Frame, strike?: false, spare?: false, partial_score: 7, update_columns: nil)] }

    subject { described_class.new(frames) }

    it 'uses the partial_score' do
      subject.call!
      expect(frames.first).to have_received(:update_columns).with(score: 7)
    end

    context 'when the evaluated frame is a strike' do
      let(:frames) { [instance_double(Frame, strike?: true, update_columns: nil)] }

      subject { described_class.new(frames) }

      it 'uses the method strike_score' do
        allow(subject).to receive(:strike_score).and_return(10)
        subject.call!
        expect(subject).to have_received(:strike_score).with(0)
        expect(frames.first).to have_received(:update_columns).with(score: 10)
      end
    end

    context 'when the evaluated frame is a spare' do
      let(:frames) { [instance_double(Frame, strike?: false, spare?: true, update_columns: nil)] }

      subject { described_class.new(frames) }

      it 'uses the method spare_score' do
        allow(subject).to receive(:spare_score).and_return(5)
        subject.call!
        expect(subject).to have_received(:spare_score).with(0)
        expect(frames.first).to have_received(:update_columns).with(score: 5)
      end
    end
  end

  describe '#strike_score' do
    let(:index) { 0 }
    let(:frames) do
      [
        instance_double(Frame, partial_score: 10, last?: false),
        instance_double(Frame, ball_one_pins: 3, ball_two_pins: 2, strike?: false)
      ]
    end

    it 'returns the strike score of the frame' do
      expect(described_class.new(frames).strike_score(index)).to eq(15)
    end

    context 'when frame is the last one' do
      let(:frames) { [instance_double(Frame, partial_score: 10, last?: true)] }

      it 'returns the partial score of the last frame' do
        expect(described_class.new(frames).strike_score(index)).to eq(10)
      end
    end

    context 'when the next two frames are a strike and a spare/normal' do
      let(:frames) do
        [
          instance_double(Frame, partial_score: 10, last?: false, frame_number: 1),
          instance_double(Frame, partial_score: 10, strike?: true, frame_number: 2),
          instance_double(Frame, partial_score: 2, ball_one_pins: 2, strike?: false, frame_number: 3)
        ]
      end

      it 'returns the partial score of the last frame' do
        expect(described_class.new(frames).strike_score(index)).to eq(22)
      end
    end

    context 'when next two frames are strikes' do
      let(:frames) do
        [
          instance_double(Frame, partial_score: 10, last?: false),
          instance_double(Frame, partial_score: 10, strike?: true),
          instance_double(Frame, partial_score: 10, strike?: true)
        ]
      end

      it 'returns the partial score of the last frame' do
        expect(described_class.new(frames).strike_score(index)).to eq(30)
      end
    end
  end

  describe '#spare_score' do
    let(:index) { 0 }
    let(:frames) do
      [
        instance_double(Frame, partial_score: 10, last?: false),
        instance_double(Frame, ball_one_pins: 2, last?: false)
      ]
    end

    it 'returns the spare score of the frames' do
      expect(described_class.new(frames).spare_score(index)).to eq(12)
    end

    context 'when frame is the last one' do
      let(:index) { 0 }
      let(:frames) { [instance_double(Frame, partial_score: 10, last?: true)] }

      it 'returns the partial score of the last frame' do
        expect(described_class.new(frames).spare_score(index)).to eq(10)
      end
    end
  end
end
