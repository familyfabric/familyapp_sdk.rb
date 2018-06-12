module FamilyappSdk
  class Message
    attr_accessor :content, :iv, :key_version, :image, :video, :template, :quick_replies

    def initialize(content: nil, family_id: nil, conversation_id: nil, image: nil, video: nil, template: nil, quick_replies: nil)
      prepare_content(content, family_id, conversation_id)
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

    def self.decrypt(content, iv, family_id, conversation_id, key_version)
      key = ::FamilyappSdk::KeyStore.instance.key_for(family_id, conversation_id, key_version)
      if key && iv.present?
        aes = OpenSSL::Cipher::AES128.new :CBC
        aes.decrypt
        aes.key = key.unpack('m')[0]
        aes.iv = iv.unpack('m')[0]
        plain = aes.update(content.unpack('m')[0])
        plain << aes.final
        plain
      else
        content
      end
    end

    private

    def prepare_content(msg, family_id, conversation_id)
      last_key = ::FamilyappSdk::KeyStore.instance.last_key_for(family_id, conversation_id)
      if last_key
        aes = OpenSSL::Cipher::AES128.new :CBC
        aes.encrypt
        aes.key = last_key[:key].unpack('m')[0]
        @iv = [aes.random_iv].pack('m')
        cipher = aes.update(msg) + aes.final
        @content = [cipher].pack('m')
        @key_version = last_key[:version]
      else
        @iv = nil
        @key_version = nil
        @content = msg
      end
    end
  end
end
