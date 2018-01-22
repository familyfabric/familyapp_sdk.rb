module FamilyappSdk
  module Components
    class Button
      attr_accessor :url, :payload, :title, :type

      def initialize(type:, title:, payload: nil, url: nil)
        @button_type = type
        @title = title
        @payload = payload
        @url = url
      end

      def build
        instance_values.delete_if { |_attribute, value| value.nil? }
      end
    end
  end
end
