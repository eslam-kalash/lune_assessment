class MoviesController < ApplicationController
  def index
    @movies = Movie.includes(:reviews).all
  end
end
