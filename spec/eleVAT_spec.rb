require "spec_helper"

describe EleVAT do
  describe "#configure" do
    before do
      EleVAT.configure do |config|
        config.basic_tax_rate = 10
      end
    end

    it "return the basic_tax_rate as an Integer" do
      basic_tax_rate = EleVAT.basic_tax_rate

      expect(basic_tax_rate).to be_a(Integer)
      expect(basic_tax_rate).to eq(10)
    end
  end
end