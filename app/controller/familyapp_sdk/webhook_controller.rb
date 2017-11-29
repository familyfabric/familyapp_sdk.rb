module FamilyappSdk
  class WebhookController < ActionController::Base
    def ensure_request_authorized
      head :unauthorized if token_from_header != ::FamilyappSdk.config.verify_token
    end

    private

    def token_from_header
      request.headers['Authorization'].split.last unless request.headers['Authorization'].nil?
    end
  end
end