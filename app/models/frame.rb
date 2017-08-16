class Frame < ApplicationRecord
  belongs_to :player

  before_validation :set_frame_number, on: :create

  validates_numericality_of :ball_one_pins, :ball_two_pins,
    :ball_three_pins, :score, only_integer: true
  validates_numericality_of :ball_one_pins, :ball_two_pins,
    :ball_three_pins, greater_than_or_equal_to: 0, less_than_or_equal_to: 10
  validates_numericality_of :score, greater_than_or_equal_to: 0, less_than_or_equal_to: 300
  validate :frame_cannot_be_added_when_game_finished,
    :dropped_pins_cannot_be_higher_than_ten,
    :third_throw_not_yet_allowed

  after_save :update_score

  default_scope { order(:frame_number) }

  def strike?
    ball_one_pins == 10
  end

  def spare?
    !strike? && partial_score == 10
  end

  def last?
    frame_number == 10
  end

  def partial_score
    ball_one_pins + ball_two_pins + ball_three_pins
  end

  private

    def update_score
      ScoreCalculator.new(player.frames).call!
    end

    def set_frame_number
      self.frame_number = player.frames.count + 1 if frame_number.blank?
    end

    def frame_cannot_be_added_when_game_finished
      errors.add(:frame_number, :game_over) if frame_number >= 11
    end

    def dropped_pins_cannot_be_higher_than_ten
      errors.add(:partial_score, :impossible_values) if frame_number <= 9 && partial_score > 10
    end

    def third_throw_not_yet_allowed
      errors.add(:ball_three_pins, :not_yet_allowed) if frame_number <= 9 && ball_three_pins != 0
    end
end
