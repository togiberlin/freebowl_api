class Player < ApplicationRecord
  belongs_to :game
  has_many :frames, dependent: :destroy

  validates_presence_of :name
  validates_length_of :name, maximum: 50
end
