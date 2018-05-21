module FamilyappSdk
  class RsaKeyLoader
    def load
      if File.exist?(FamilyappSdk.config.rsa_key_path)
        if FamilyappSdk.config.rsa_key_password.nil?
          key = OpenSSL::PKey::RSA.new File.read(FamilyappSdk.config.rsa_key_path)
        else
          key = OpenSSL::PKey::RSA.new File.read(FamilyappSdk.config.rsa_key_path), FamilyappSdk.config.rsa_key_password
        end
      else
        key = OpenSSL::PKey::RSA.new(2048)
        if FamilyappSdk.config.rsa_key_password.nil?
          save_to_file(key)
        else
          cipher = OpenSSL::Cipher::AES256.new(:CBC)
          password = Digest::SHA256.hexdigest(SecureRandom.uuid)
          save_to_file(key, cipher, password)
          FamilyappSdk.config.rsa_key_password = password
        end
      end
      key
    end
  end

  private

  def save_to_file(key, cipher, password)
    begin
      file = File.open(FamilyappSdk.config.rsa_key_path, 'w')
      cipher && password ? file.write(key.to_pem(cipher, password)) : file.write(key.to_pem)
    rescue IOError => e
      raise e
    ensure
      file.close unless file.nil?
    end
  end
end
