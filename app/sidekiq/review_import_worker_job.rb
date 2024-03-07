class ReviewImportWorkerJob
  include Sidekiq::Job

  def perform(reviews)
    # Do something
    data = JSON.parse(reviews).map(&:with_indifferent_access)

    data.each do |review|
      movie = Movie.find_by_title(review[:movie])
      if movie.present?
        review.delete(:movie)
        movie.reviews.create(review)
      end
    end
  end
end
