class MovieImportWorkerJob
  include Sidekiq::Job

  def perform(params)
    # Do something
    data = JSON.parse(params).map(&:with_indifferent_access)
    data.each do |movie_data|
      filming_location = { city: movie_data[:filming_location], country: movie_data[:country] }
      movie_data[:filming_location] = [filming_location].to_json
      movie_data.delete(:country)
      store_actor_name = movie_data.delete(:actor)
      movie_title = movie_data[:title]

      # Check if the movie already exists in the database
      movie = Movie.find_by(title: movie_title)

      unless movie.present?
        # Create the movie if it doesn't exist
        movie = Movie.create(movie_data)
        movie.attach_actor(store_actor_name)
      else
        movie.attach_actor(store_actor_name)
      end
    end
  end
end
