class Movie < ApplicationRecord
  has_many :cast_members
  has_many :actors, through: :cast_members
  has_many :reviews
  validates :title, presence: true, uniqueness: true
  validates :year, numericality: { only_integer: true }


  def attach_actor(store_actor_name)
    # Find or create the actor and associate them with the movie
    actor = Actor.find_or_create_by(name: store_actor_name)
    CastMember.create(movie: self, actor: actor) if actors.where(name: store_actor_name).count ==  0
  end
end
