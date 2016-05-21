module EleVAT
  class Product
    attr_accessor :quantity, :name, :net_price, :gross_price,
                  :tax, :imported, :taxable

    def initialize(quantity, name, net_price, taxable = true, imported = false)
      @quantity = quantity
      @name = name
      @net_price = net_price
      @taxable = taxable
      @imported = imported
      @gross_price = nil
      @tax = nil
      validate_product
    end

    def prepare_for_receipt
      calculate_tax
      {
        name: @name,
        quantity: @quantity,
        net_price: @net_price,
        gross_price: @gross_price,
        tax: @tax,
        imported: @imported,
        taxable: @taxable
      }
    end

    private

    def calculate_tax
      tax = 0.0
      @imported && tax += CalculatorHelper.percentage(
        @net_price, EleVAT.config.import_tax_rate
      )
      @taxable && tax += CalculatorHelper.percentage(
        @net_price, EleVAT.config.basic_tax_rate
      )
      @tax = CalculatorHelper.round(tax) * @quantity
      gross_price = @tax + @net_price * @quantity
      @gross_price = gross_price.round 2
    end

    def validate_product
      validate_net_price
      validate_name
      validate_quantity
    end

    def validate_net_price
      net_price_is_a_float = @net_price.class == Float
      net_price_gt_zero = @net_price > 0.0

      fail ArgumentError, 'Net price must be a float > 0.0' unless
        net_price_is_a_float && net_price_gt_zero
    end

    def validate_name
      name_is_blank = name.nil? || name == ''
      fail ArgumentError, 'Invalid name' if name_is_blank
    end

    def validate_quantity
      quantity_is_gt_zero = quantity > 0
      quantity_is_int = quantity.class == Fixnum
      fail ArgumentError, 'Invalid quantity' unless
        quantity_is_int && quantity_is_gt_zero
    end
  end
end