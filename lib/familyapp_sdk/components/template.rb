module FamilyappSdk
  module Components
    class Template
      attr_accessor :template_type, :elements, :buttons

      def initialize(type:, elements: nil, buttons: nil)
        @template_type = type
        @elements = build_attributes(elements)
        @buttons = build_attributes(buttons)
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