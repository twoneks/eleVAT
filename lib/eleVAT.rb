require "eleVAT/version"

module EleVAT
  def self.configure
    @config ||= Configuration.new
    yield(@config) if block_given?
    @config
  end

  def self.config
    @config || configure
  end

  class Configuration
    attr_accessor :basic_tax_rate, :import_tax

    def initialize
      @basic_tax_rate = 10
      @import_tax = 5
    end
  end
end
