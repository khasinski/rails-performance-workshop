require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Adopter
  class Application < Rails::Application
    config.load_defaults 6.1

    config.time_zone = "UTC"

    config.generators.stylesheets = false
    config.generators.javascripts = false
    config.generators.jbuilder = false
    config.generators.helper = false
    config.generators.test_framework(
      :rspec,
      fixture: false,
      route_specs: false,
      view_specs: false,
      helper_specs: false,
      controller_specs: false
    )
  end
end
