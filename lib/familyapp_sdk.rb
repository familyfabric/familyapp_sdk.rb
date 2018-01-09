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
require 'familyapp_sdk/message'

require 'familyapp_sdk/components/button'
require 'familyapp_sdk/components/element'
require 'familyapp_sdk/components/quick_reply'
require 'familyapp_sdk/components/template'
