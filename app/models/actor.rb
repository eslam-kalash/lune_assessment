class Actor < ApplicationRecord
  has_many :cast_members
  has_many :movies, through: :cast_members

  validates :name, presence: true, uniqueness: true
end
