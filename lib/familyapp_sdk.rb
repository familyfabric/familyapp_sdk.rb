require 'familyapp_sdk/version'
require 'familyapp_sdk/configuration'
require 'familyapp_sdk/rsa_key_loader'

module FamilyappSdk
  class << self
    attr_accessor :config, :rsa_key

    def configure
      @config ||= Configuration.new
      yield(config)
      load_rsa_key
      update_remote_key
    end

    def reset
      @config = Configuration.new
    end

    def load_rsa_key
      @rsa_key = RsaKeyLoader.new.load
    end

    def update_remote_key
      Client.update_bot({rsa_key_attributes: {key: @rsa_key.public_key}})
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
