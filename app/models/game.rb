class Game < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :frames, through: :players

  validates_presence_of :created_by
  validates_length_of :created_by, maximum: 50
end
