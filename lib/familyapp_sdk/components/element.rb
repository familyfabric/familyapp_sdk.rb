module FamilyappSdk
  module Components
    class Element
      attr_accessor :type, :title, :subtitle, :image, :url, :payload, :buttons

      def initialize(type:, title: nil, subtitle: nil, image: nil, url: nil, payload: nil, buttons: nil)
        @type = type
        @title = title
        @subtitle = subtitle
        @image = image
        @url = url
        @payload = payload
        @buttons = build_buttons(buttons)
      end

      def build
        instance_values.delete_if { |_attribute, value| value.nil? }
      end
    end
  end
end
