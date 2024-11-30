# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module InssDiscount
  # InssDiscount::Application é a classe principal que configura o aplicativo Rails.
  # Ela define configurações como o fuso horário, a localidade, o carregamento de arquivos de idiomas,
  # o caminho de carregamento automático para os serviços, e a codificação de caracteres.
  #
  # As configurações de idioma e fuso horário são específicas para o Brasil, e a aplicação está configurada
  # para usar o idioma português do Brasil como padrão.
  #
  class Application < Rails::Application
    config.load_defaults 7.1

    config.time_zone = 'Brasilia'

    config.i18n.available_locales = ['pt-BR']
    config.i18n.default_locale = 'pt-BR'
    config.i18n.fallbacks = ['pt-BR']
    config.i18n.locale = 'pt-BR'
    config.i18n.load_path += Dir["#{config.root}/config/locales/*.yml"]

    config.autoload_paths += %W[#{config.root}/app/services]

    config.encoding = 'utf-8'
  end
end
