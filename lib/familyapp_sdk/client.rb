require 'rest-client'

module FamilyappSdk
  class Client
    def self.update_profile(family_id, family_user_id, data)
      url = "/bot_api/v1/families/#{family_id}/family_users/#{family_user_id}"
      RestClient.patch(
        FamilyappSdk.config.api_host + url,
        data,
        { Authorization: FamilyappSdk.config.access_token }
      ) { |response, request, result| response }
    end

    def self.send(family_id, conversation_id, data)
      url = "/bot_api/v1/families/#{family_id}/conversations/#{conversation_id}/messages"
      RestClient.post(
        FamilyappSdk.config.api_host + url,
        data,
        { Authorization: FamilyappSdk.config.access_token }
      ) { |response, request, result| response }
    end
  end
end