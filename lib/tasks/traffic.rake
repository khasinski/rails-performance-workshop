namespace :traffic do
  desc "Walk around the page"
  task :go, [:host] do |_t, args|
    require 'faraday'
    require 'nokogiri'
    host = ENV.fetch('TRAFFIC_GENERATOR_HOST', args[:host])
    sleep_time = ENV.fetch('TRAFFIC_GENERATOR_SLEEP_TIME', 1).to_i

    # wait for server to start
    loop do
      begin
        Faraday.new("http://#{host}:3000").get('/') {}
        break
      rescue StandardError
        sleep sleep_time
      end
    end

    collected_urls = Hash.new(0)
    collected_urls["/"] = 1

    loop do
      begin
        url = collected_urls.keys.sample
        res = Faraday.new("http://#{host}:3000").get(url) {}

        Nokogiri::HTML(res.body).css('a').map do |link|
          collected_urls[link['href']] += 1
        end
        puts collected_urls
        sleep sleep_time
      rescue StandardError => e
        puts e.message
        sleep sleep_time
      end
    end

  end
end
