require 'rest-client'

module FamilyappSdk
  class Client
    def self.get_family(family_id)
      url = "/bot_api/v1/families/#{family_id}"
      RestClient.get(
        FamilyappSdk.config.api_host + url,
        { Authorization: FamilyappSdk.config.access_token }
      ) { |response, request, result| response }
    end

    def self.update_profile(family_id, family_user_id, data)
      url = "/bot_api/v1/families/#{family_id}/family_users/#{family_user_id}"
      RestClient.patch(
        FamilyappSdk.config.api_host + url,
        data,
        { Authorization: FamilyappSdk.config.access_token }
      ) { |response, request, result| response }
    end

    def self.update_bot(data)
      url = "/bot_api/v1/bot"
      RestClient.patch(
        FamilyappSdk.config.api_host + url,
        data,
        { Authorization: FamilyappSdk.config.access_token }
      ) { |response, request, result| response }
    end

    def self.update_rsa_key(data)
      url = "/bot_api/v1/rsa_keys"
      RestClient.post(
          FamilyappSdk.config.api_host + url,
          data,
          { Authorization: FamilyappSdk.config.access_token }
      ) { |response, request, result| response }
    end

    def self.send(family_id, conversation_id, data)
      url = "/bot_api/v1/families/#{family_id}/conversations/#{conversation_id}/messages"
      RestClient.post(
        FamilyappSdk.config.api_host + url,
        data.build.to_json,
        { Authorization: FamilyappSdk.config.access_token,
          content_type: :json }
      ) { |response, request, result| response }
    end
  end
end