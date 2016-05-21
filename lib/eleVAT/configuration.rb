module EleVAT
  class Configuration
    attr_accessor :basic_tax_rate, :import_tax_rate, :rounding_precision,
                  :tax_free_items, :import_label

    def initialize
      @basic_tax_rate = 10
      @import_tax_rate = 5
      @rounding_precision = 0.05
      @tax_free_items = %w(chocolate chocolates pills book)
      @import_label = 'imported'
    end
  end
end
