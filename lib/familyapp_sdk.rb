require 'familyapp_sdk/version'
require 'familyapp_sdk/configuration'

module FamilyappSdk
  class << self
    attr_accessor :config, :rsa_key

    def configure
      @config ||= Configuration.new
      yield(config)
      load_rsa_key
    end

    def reset
      @config = Configuration.new
    end
    
    def load_rsa_key
      if File.exist?(@config.rsa_key_path)
        if @config.rsa_key_password.nil?
          key = OpenSSL::PKey::RSA.new File.read(@config.rsa_key_path)
        else
          key = OpenSSL::PKey::RSA.new File.read(@config.rsa_key_path), @config.rsa_key_password
        end
      else
        key = OpenSSL::PKey::RSA.new(2048)
        if @config.rsa_key_password.nil?
          file = File.open(@config.rsa_key_path, 'w') {|file| file.write key.to_pem}
        else
          cipher = OpenSSL::Cipher::AES256.new(:CBC)
          password = Digest::SHA256.hexdigest SecureRandom.uuid
          file = File.open(@config.rsa_key_path, 'w') {|file| file.write key.to_pem(cipher,password)}
          @config.rsa_key_password = password
        end
        file.close
      end
      @rsa_key = key
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
