namespace :csv_import do
  desc "Import Movies CSV records to the queue"
  task :movies, [:file] => :environment do |task, args|
    csv_file_path = args[:file]
    if csv_file_path.nil?
      puts "Usage: rake csv_import:movies[file_path]"
      exit
    end

    options = { :chunk_size => 500,  :key_mapping => {:movie => :title} }
    importing_movies_and_actors = SmarterCSV.process(csv_file_path, options) do |chunk|
      MovieImportWorkerJob.perform_async(chunk.to_json)
    end
    puts "done #{importing_movies_and_actors.inspect}"
  end
  desc "Import Reviews CSV records to the queue"
  task :reviews, [:file] => :environment do |task, args|
    csv_file_path = args[:file]
    if csv_file_path.nil?
      puts "Usage: rake csv_import:reviews[file_path]"
      exit
    end
    options = { :chunk_size => 500 }
    importing_reviews = SmarterCSV.process(csv_file_path, options) do |chunk|
      ReviewImportWorkerJob.perform_async(chunk.to_json)
    end
    puts "done #{importing_reviews.inspect}"
  end
end
