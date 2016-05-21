require 'spec_helper'

describe EleVAT do
  describe 'configuration default values' do
    it 'has default basic_tax_rate set to 10' do
      basic_tax_rate = EleVAT.config.basic_tax_rate
      expect(basic_tax_rate).to eq(10)
    end
  end
  describe 'configure' do
    before do
      EleVAT.configure do |config|
        config.basic_tax_rate = 22
      end
    end

    describe 'allow to set custom configuration' do
      it 'returns the custom basic_tax_rate' do
        basic_tax_rate = EleVAT.config.basic_tax_rate

        expect(basic_tax_rate).to be_a(Integer)
        expect(basic_tax_rate).to eq(22)
      end
    end

    after do
      EleVAT.configure do |config|
        config.basic_tax_rate = 10
      end
    end
  end
end