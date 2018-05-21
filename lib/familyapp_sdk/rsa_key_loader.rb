if File.exist?(FamilyappSdk.config.rsa_key_path)
  if FamilyappSdk.config.rsa_key_password.nil?
    key = OpenSSL::PKey::RSA.new File.read(FamilyappSdk.config.rsa_key_path)
  else
    key = OpenSSL::PKey::RSA.new File.read(FamilyappSdk.config.rsa_key_path), FamilyappSdk.config.rsa_key_password
  end
else
  key = OpenSSL::PKey::RSA.new(2048)
  if FamilyappSdk.config.rsa_key_password.nil?
    file = File.open(FamilyappSdk.config.rsa_key_path, 'w') {|file| file.write key.to_pem}
  else
    cipher = OpenSSL::Cipher::AES256.new(:CBC)
    password = Digest::SHA256.hexdigest SecureRandom.uuid
    file = File.open(FamilyappSdk.config.rsa_key_path, 'w') {|file| file.write key.to_pem(cipher,password)}
    FamilyappSdk.config.rsa_key_password = password
  end
  file.close
end

FamilyappSdk.rsa_key = key