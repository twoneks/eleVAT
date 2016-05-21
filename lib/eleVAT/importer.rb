module EleVAT
  class Importer
    attr_accessor :imported_data

    def initialize(input_data)
      begin
        if input_data.class == String
          @imported_data = initialize_string(input_data)
        elsif input_data.content_type == 'text/csv'
          @imported_data = initialize_csv(input_data)
        elsif input_data.content_type == 'application/vnd.ms-excel'
          @imported_data = initialize_xcell(input_data)
        end
      rescue
        raise NotImplementedError, 'Your data import is not precessable yet'
      end
    end

    def export_data_for_receipt
      @imported_data.map { |p| p.prepare_for_receipt }
    end

    private

    def initialize_string(input_data)
      products = []
      tmp_array = input_data.strip.split(/ (?=\d+)/)
      tmp_array.each_with_index do |product_string, index|
        next unless index.even?
        product_array = product_string.split(' ')
        quantity = product_array.shift.to_i
        imported = product_string.downcase.include? EleVAT.config.import_label
        taxable = taxable?(product_array)
        name = build_name(product_array)
        net_price = tmp_array[index + 1].to_f
        products << Product.new(
          quantity, name, net_price, taxable, imported
        )
      end
      products
    end

    def build_name(array_name)
      if (imported = array_name.delete('imported'))
        array_name.unshift(imported)
      end
      array_name[0...-1].join(' ')
    end

    def taxable?(product)
      (product & EleVAT.config.tax_free_items).empty?
    end

    def initialize_csv
      # TO _DO
      fail NotImplementedError, 'Your data import is not precessable yet'
    end

    def initialize_xcell
      # TO _DO
      fail NotImplementedError, 'Your data import is not precessable yet'
    end
  end
end