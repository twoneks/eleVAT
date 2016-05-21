require 'spec_helper'

module EleVAT
  describe Receipt do
    it 'has a valid constructor' do
      receipt = Receipt.new
      expect(receipt).not_to be_nil
    end

    describe 'add' do
      before(:each) do
        @product = Product.new(1, 'Chocolate', 2.0)
        @receipt = Receipt.new
      end
      it 'add product to a list' do
        @receipt.add(@product)
        expect(@receipt.size).to eq 1
      end

      it 'add the array to the list' do
        @receipt.add([@product, @product])
        expect(@receipt.size).to eq 2
      end

      it 'raise exception adding something different from Product' do
        string = 'Chocolate'
        expect { @receipt.add(string) }.to raise_error ArgumentError
      end
    end

    describe 'calculation' do
      before(:each) do
        product_1 = Product.new(1, 'pc', 1000.00).prepare_for_receipt
        product_2 = Product.new(1, 'box of chocolate', 0.85, false).prepare_for_receipt
        product_3 = Product.new(
          2, 'imported bottle of perfume', 27.99, true, true
        ).prepare_for_receipt
        @receipt = Receipt.new
        @receipt.products << product_1
        @receipt.products << product_2
        @receipt.products << product_3
      end

      it 'calculate_total is the total amout of the receipt' do
        @receipt.calculate_total
        total_amount = 1100 + 0.85 + (32.19 * 2)
        expect(@receipt.total_amount).to eq total_amount
      end

      it 'calculate_taxes is the total amout of taxes' do
        @receipt.calculate_taxes
        total_amount_of_taxes = 100.0 + 0.0 + (4.20 * 2)
        expect(@receipt.taxes).to eq total_amount_of_taxes
      end
    end

    describe 'rappresentation' do
      it 'to_s return the correct formatted output' do
        product_1 = Product.new(1, 'pc', 1000.00)
        product_2 = Product.new(1, 'box of chocolate', 0.85, false)
        product_3 = Product.new(
          2, 'imported bottle of perfume', 27.99, true, true
        )
        @receipt = Receipt.new
        @receipt.products << product_1.prepare_for_receipt
        @receipt.products << product_2.prepare_for_receipt
        @receipt.products << product_3.prepare_for_receipt
        output =
          "#{product_1.quantity} #{product_1.name}: "\
          "#{CalculatorHelper.num_to_currency(product_1.gross_price)} "\
          "#{product_2.quantity} #{product_2.name}: "\
          "#{CalculatorHelper.num_to_currency(product_2.gross_price)} "\
          "#{product_3.quantity} #{product_3.name}: "\
          "#{CalculatorHelper.num_to_currency(product_3.gross_price)} "\
          "Sales Taxes: #{CalculatorHelper.num_to_currency(108.40)} "\
          'Total: 1165.23'
        expect(output).to eq(@receipt.to_s)
      end
    end
  end
end