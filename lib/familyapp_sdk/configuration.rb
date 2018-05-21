module FamilyappSdk
  class Configuration
    DEFAULT_RSA_KEY_PATH = 'rsa.pem'
    attr_accessor :access_token, :verify_token, :api_host, :rsa_key_password, :rsa_key_path

    def initialize(access_token: nil, verify_token: nil, api_host: nil, rsa_key_password: nil)
      @access_token = access_token
      @verify_token = verify_token
      @api_host = api_host || 'https://api.familyapp.com'
      @rsa_key_password = rsa_key_password
      @rsa_key_path = DEFAULT_RSA_KEY_PATH
    end
  end
end