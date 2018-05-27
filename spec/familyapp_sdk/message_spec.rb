require 'spec_helper'

RSpec.describe FamilyappSdk::Message do
  let(:message) { { content: 'XBKD0p1s1qwd5ZFOf3bqKw==', iv: 'uFaf0QEfFHXLp42mwbXoGQ==', key_version: 1, conversation_id: 1 } }
  let(:key) { '1YP89jtXpWDVbsfAVFStR2LGuE+hvpoIXnd8NbS/WG4=' }
  let(:json) { [{ version: 1, key: key }] }

  context 'decrypt' do
    it 'proper encrypt content' do
      key_store = double()
      allow(FamilyappSdk::KeyStore).to receive(:instance).and_return key_store
      allow(key_store).to receive(:key_for).with(1, 1).and_return(key)
      expect(FamilyappSdk::Message.decrypt(message)).to eq('Ram pam pam.')
    end
  end

  context 'encrypt' do
    it 'encrypt message when key exists' do
      key_store = double()
      allow(FamilyappSdk::KeyStore).to receive(:instance).and_return key_store
      allow(key_store).to receive(:last_key_for).with(1).and_return(json[0])
      msg = FamilyappSdk::Message.new(content: 'Ram pam pam.', conversation_id: 1)
      expect(msg.content).to_not eq('Ram pam pam.')
      expect(msg.iv).to_not eq nil
    end
  end
end
