namespace :traffic do
  desc "Walk around the page"
  task :go => :environment do
    Thread.
    client = Faraday.new('http://localhost:3000')
    loop do
      client.get '/', {

      }
      sleep 0.01
    end
  end
end
