namespace :generate do
  desc "Generate data for the app"
  task :data => :environment do |_t, _args|
    pet_batches = (Pet.count / 100).to_i

    GenerateDataJob.new.perform(
      10_000 - pet_batches
    ) if pet_batches < 10_000
  end
end
