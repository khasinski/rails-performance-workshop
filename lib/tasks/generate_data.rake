namespace :generate do
  task :data => :environment do |t, args|
    GenerateDataJob.perform_now((args[:data_generation_loop_size] || 100).to_i)
  end
end
