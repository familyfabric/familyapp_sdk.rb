require 'familyapp_sdk/version'
require 'familyapp_sdk/configuration'
require 'familyapp_sdk/rsa_key_loader'
require 'familyapp_sdk/key_store'

module FamilyappSdk
  class << self
    attr_accessor :config, :rsa_key, :key_store

    def configure
      @config ||= Configuration.new
      yield(config)
      load_rsa_key
      update_remote_key
      @key_store = KeyStore.instance
    end

    def reset
      @config = Configuration.new
    end

    def load_rsa_key
      @rsa_key = RsaKeyLoader.new.load
    end

    def update_remote_key
      Client.update_rsa_key({key: @rsa_key.public_key})
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
