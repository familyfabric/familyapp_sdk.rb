module FamilyappSdk
  module Components
    class Template
      attr_accessor :template_type, :elements_attributes, :buttons_attributes

      def initialize(type:, elements: nil, buttons: nil)
        @template_type = type
        @elements_attributes      = build_attributes(elements)
        @buttons_attributes       = build_attributes(buttons)
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