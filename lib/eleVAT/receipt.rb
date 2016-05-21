module EleVAT
  class Receipt
    attr_accessor :products, :total_amount, :taxes

    def initialize(products = [])
      @products = products
      @total_amount = 0.0
      @taxes = 0.0
    end

    def add(product)
      if product.class == Product
        @products << product
      elsif product.class == Array && product.all? { |p| p.is_a?(Product) }
        @products = product
      else
        fail ArgumentError, 'Parameter must be EleVAT::Product '\
                            'or an array of Products'
      end
    end

    def calculate_total
      @total_amount =
        @products.map { |product| product[:gross_price] }.inject(:+).round 2
    end

    def calculate_taxes
      @taxes = @products.map { |product| product[:tax] }.inject(:+).round 2
    end

    def to_s
      @total_amount == 0.0 && calculate_total
      @taxes == 0.0 && calculate_taxes

      output = @products.map do |product|
        "#{product[:quantity]} #{product[:name]}: "\
        "#{CalculatorHelper.num_to_currency(product[:gross_price])} "
      end
      output << ("Sales Taxes: #{CalculatorHelper.num_to_currency(@taxes)} "\
        "Total: #{CalculatorHelper.num_to_currency(@total_amount)}")
      output.join
    end

    def size
      @products.size
    end

    def to_xcell
      # TO _DO
      fail NotImplementedError
    end

    def to_csv
      # TO _DO
      fail NotImplementedError
    end
  end
end