require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Wishfriends
  class Application < Rails::Application
    config.load_defaults 7.1
    config.autoload_lib(ignore: %w(assets tasks))

    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore, key: '_wishfriends_session'
    config.api_only = true
  end
end
