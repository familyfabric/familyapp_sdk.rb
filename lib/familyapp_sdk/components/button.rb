module FamilyappSdk
  module Components
    class Button
      attr_accessor :web_url, :payload, :title, :type

      def initialize(type:, title:, payload: nil, web_url: nil)
        @button_type  = type
        @title = title
        @payload = payload
        @url = web_url
      end

      def build
        instance_values.delete_if { |_attribute, value| value.nil? }
      end
    end
  end
end
