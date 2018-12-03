module FamilyappSdk
  class RsaKeyLoader
    def load
      raise StandardError, 'RSA KEY PASSWORD MUST BE PROViDED' if FamilyappSdk.config.rsa_key_password.nil?
      if File.exist?(FamilyappSdk.config.rsa_key_path)
        key = OpenSSL::PKey::RSA.new File.read(FamilyappSdk.config.rsa_key_path), FamilyappSdk.config.rsa_key_password
      else
        key = OpenSSL::PKey::RSA.new(2048)
        cipher = OpenSSL::Cipher::AES256.new(:CBC)
        save_to_file(key, cipher, FamilyappSdk.config.rsa_key_password)
      end
      key
    end

    private

    def save_to_file(key, cipher = nil, password = nil)
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
end
