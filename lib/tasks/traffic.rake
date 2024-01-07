namespace :traffic do
  desc "Walk around the page"
  task :go, [:host] => :environment do |_t, args|
    host = args[:host] || 'localhost'
    client = Faraday.new("http://#{host}:3000")
    loop do
      begin
        client.get '/', {

        }
        sleep 0.01
      rescue
        sleep(5)
        next
      end
    end
  end
end
