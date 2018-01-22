module FamilyappSdk
  class Message
    attr_accessor :content, :image, :video, :template, :quick_replies

    def initialize(content: nil, image: nil, video: nil, template: nil, quick_replies: nil)
      @content = content
      @image = image
      @video = video
      @template = template.build.to_json if template.present?
      @quick_replies_attributes = build_quick_replies(quick_replies)
    end

    def build
      instance_values.delete_if { |_attribute, value| value.nil? }
    end

    def build_quick_replies(quick_replies)
      quick_replies.map { |quick_reply| quick_reply.build } if quick_replies.present?
    end
  end
end
