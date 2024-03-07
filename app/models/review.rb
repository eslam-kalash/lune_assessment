class Review < ApplicationRecord
  belongs_to :movie

  validates :movie_id, :user, :stars, :review, presence: true
  validates :stars, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
