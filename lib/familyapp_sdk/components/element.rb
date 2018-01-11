module FamilyappSdk
  module Components
    class Element
      attr_accessor :title, :subtitle, :image, :url, :payload, :buttons

      def initialize(title:, subtitle: nil, image: nil, url: nil, payload: nil, buttons: nil)
        @title = title
        @subtitle = subtitle
        @image = image
        @url = url
        @payload = payload
        @buttons_attributes = build_attributes(buttons)
      end

      def build
        instance_values.delete_if { |_attribute, value| value.nil? }
      end

      def build_attributes(attributes)
        attributes.map(&:build) if attributes.present?
      end
    end
  end
end
