require 'familyapp_sdk/version'
require 'familyapp_sdk/configuration'

module FamilyappSdk
  class << self
    attr_accessor :config

    def config
      @config ||= Configuration.new
    end

    def configure
      yield(config)
    end

    def reset
      @config = Configuration.new
    end
  end
end

require 'familyapp_sdk/engine'
require 'familyapp_sdk/client'
