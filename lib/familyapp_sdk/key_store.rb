require 'base64'

module FamilyappSdk
  class KeyStore
    def initialize
      @keys ||= {}
    end

    @@instance = KeyStore.new

    def self.instance
      @@instance
    end

    def last_key_for(family_id, conversation_id)
      response = Client.get_conversation_key_versions(family_id, conversation_id)
      parse_response(conversation_id, response) if response.code == 200
      max_version = @keys[conversation_id].keys.max if @keys[conversation_id]
      if max_version && @keys.dig(conversation_id, max_version)
        @keys[conversation_id][max_version][:decrypted_key] ||= decrypt(@keys[conversation_id][max_version][:encrypted_key])
        return { version: max_version, key: @keys[conversation_id][max_version][:decrypted_key] }
      end

      nil
    end

    def key_for(family_id, conversation_id, key_version)
      unless @keys.dig(conversation_id, key_version)
        response = Client.get_conversation_key_versions(family_id, conversation_id)
        parse_response(conversation_id, response) if response.code == 200
      end

      if @keys.dig(conversation_id, key_version)
        @keys[conversation_id][key_version][:decrypted_key] ||= decrypt(@keys[conversation_id][key_version][:encrypted_key])
        return @keys[conversation_id][key_version][:decrypted_key]
      end

      nil
    end

    private

    def parse_response(conversation_id, response)
      @keys[conversation_id] ||= {}
      JSON.parse(response.body, {:symbolize_names => true}).each do |row|
        if row[:version].present? && row[:key].present?
          unless @keys.dig(conversation_id, row[:version])
            @keys[conversation_id][row[:version]] = { encrypted_key: row[:key][:key], decrypted_key: nil }
          end
        end
      end
    end

    def decrypt(encrypted_aes_key)
      FamilyappSdk.rsa_key.private_decrypt(Base64.decode64(encrypted_aes_key))
    end

    private_class_method :new
  end
end
