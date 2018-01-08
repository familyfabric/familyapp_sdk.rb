module FamilyappSdk
  module Components
    class QuickReply
      attr_accessor :title, :payload, :image

      def initialize(title:, payload: nil, image: nil, color: nil)
        @title = title
        @payload = payload
        @image = image
        @color = color
      end

      def build
        instance_values.delete_if { |_attribute, value| value.nil? }
      end
    end
  end
end
