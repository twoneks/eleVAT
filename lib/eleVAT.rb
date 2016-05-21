require 'eleVAT/configuration'
require 'eleVAT/product'
require 'eleVAT/receipt'
require 'eleVAT/importer'

module EleVAT
  def self.configure
    @config ||= Configuration.new
    yield(@config) if block_given?
    @config
  end

  def self.config
    @config || configure
  end

  module CalculatorHelper
    def self.round(price)
      precision = 1 / EleVAT.config.rounding_precision
      (price * precision).ceil / precision
    end

    def self.percentage(net_price, rate)
      net_price * rate / 100
    end

    def self.num_to_currency(n)
      if n.to_s.split('.').last.size == 1
        return "#{n}0"
      else
        return "#{n}"
      end
    end
  end
end
