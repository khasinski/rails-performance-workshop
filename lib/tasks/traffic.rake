namespace :traffic do
  desc "Walk around the page"
  task :go, [:host] do |_t, args|
    require 'faraday'
    require 'nokogiri'
    host = ENV.fetch('TRAFFIC_GENERATOR_HOST', args[:host] || 'localhost:3000')
    sleep_time = ENV.fetch('TRAFFIC_GENERATOR_SLEEP_TIME', 1).to_i

    puts "Starting traffic generator for #{host} with sleep time #{sleep_time}"

    # wait for server to start
    loop do
      begin
        Faraday.new("http://#{host}").get('/') {}
        break
      rescue StandardError
        puts "Waiting for server to start..."
        sleep sleep_time * 3
      end
    end

    collected_urls = {  }
    collected_urls["/"] = true

    visited_urls_count = 0

    loop do
      begin
        url = collected_urls.keys.sample
        puts "Visited #{visited_urls_count} pages. Visiting #{url}" if visited_urls_count % 10 == 0
        res = Faraday.new("http://#{host}").get(url) {}
        visited_urls_count += 1

        Nokogiri::HTML(res.body).css('a').map do |link|
          collected_urls[link['href']] ||= true
        end
        sleep sleep_time
      rescue StandardError => e
        puts e.message
        sleep sleep_time * 3
      end
    end

  end
end
