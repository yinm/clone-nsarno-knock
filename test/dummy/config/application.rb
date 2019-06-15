require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)
require 'knock'

module Dummy
  class Application < Rails::Application
    unless Gem.loaded_specs['rails'].version.to_s =~ /^5/
      config.active_record.raise_in_transactional_callbacks = true
    end
  end
end
