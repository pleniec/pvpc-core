require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PvpcCore
  class Application < Rails::Application
    config.i18n.available_locales = [:en, :pl, :de]
    config.i18n.default_locale = :en
    
    config.active_record.raise_in_transactional_callbacks = true
  end
end
