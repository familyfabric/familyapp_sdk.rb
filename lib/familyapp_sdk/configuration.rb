module FamilyappSdk
  class Configuration
    attr_accessor :access_token, :verify_token, :api_host

    def initialize(access_token: nil, verify_token: nil, api_host: nil)
      @access_token = access_token
      @verify_token = verify_token
      @api_host = api_host || 'https://api.familyapp.io'
    end
  end
end