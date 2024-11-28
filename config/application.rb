# config/application.rb
require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module InssDiscount
  class Application < Rails::Application
    config.load_defaults 7.1

    config.time_zone = 'Brasilia'

    config.i18n.available_locales = ['pt-BR']
    config.i18n.default_locale = 'pt-BR'
    config.i18n.fallbacks = ['pt-BR']
    config.i18n.locale = 'pt-BR'
    config.i18n.load_path += Dir["#{config.root}/config/locales/*.yml"]

    config.autoload_paths += %W(#{config.root}/app/services)

    config.encoding = 'utf-8'
  end
end
