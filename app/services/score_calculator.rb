class ScoreCalculator
  attr_reader :frames

  def initialize(frames)
    @frames = frames.to_a
  end

  # Determine, whether the evaluated frame is a strike, spare or normal.
  # Then, call helper methods 'strike_score', 'spare_score' or just make a sum.
  def call!
    Frame.transaction do
      frames.each_with_index do |frame, index|
        score = if frame.strike?
                  strike_score(index)
                elsif frame.spare?
                  spare_score(index)
                else
                  frame.partial_score
                end

        frame.update_columns(score: score + frame_at(index - 1).score)
      end
    end
  end

  # When the evaluated frame is a strike, the next two throws count as bonus
  def strike_score(index)
    frame = frame_at(index)
    one_frame_ahead = frame_at(index + 1)
    two_frames_ahead = frame_at(index + 2)

    return frame.partial_score if frame.last? # 10th and last frame: strike + 2 bonus throws = 3 total throws
    return 10 + 10 + 10 if one_frame_ahead.strike? && two_frames_ahead.strike? # Strike + strike + strike
    return 10 + 10 + two_frames_ahead.ball_one_pins if one_frame_ahead.strike? && frame.frame_number != 9 # Strike + strike + (normal || spare)
    10 + one_frame_ahead.ball_one_pins + one_frame_ahead.ball_two_pins # (Strike + normal + normal) || (strike + spare) || (strike + strike + strike @9th frame)
  end

  # When the evaluated frame is a spare, the next throw counts as bonus
  def spare_score(index)
    frame = frame_at(index)
    one_frame_ahead = frame_at(index + 1)

    return frame.partial_score if frame.last? # 10th and last frame: spare + 1 bonus throw = 3 total throws
    frame.partial_score + one_frame_ahead.ball_one_pins # Spare + (normal || spare || strike)
  end

  private

    # Helper method, which jumps to a specific array index position
    def frame_at(index)
      return Frame.new(frame_number: 0) if index < 0 || index >= frames.size
      frames[index]
    end
end
