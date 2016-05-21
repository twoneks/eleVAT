require 'spec_helper'

module EleVAT
  describe 'Final integration test.' do
    describe 'Suppling the given test data the application works!' do
      it 'Input 1:
          1 book at 12.49 1 music CD at 14.99 1 chocolate bar at 0.85
          returns:
          1 book: 12.49 1 music CD: 16.49 1 chocolate bar: 0.85
          Sales Taxes: 1.50 Total: 29.83' do
        importer = Importer.new(
          '1 book at 12.49 1 music CD at 14.99 1 chocolate bar at 0.85'
        )
        data_for_receipt = importer.export_data_for_receipt
        receipt = Receipt.new data_for_receipt
        output = receipt.to_s
        expect(output).to eq('1 book: 12.49 1 music CD: 16.49 1 chocolate bar: 0.85 Sales Taxes: 1.50 Total: 29.83')
      end

      it 'Input 2:
          1 imported box of chocolates at 10.00
          1 imported bottle of perfume at 47.50
          returns:
          1 imported box of chocolates: 10.50 1 imported bottle of
          perfume: 54.65 Sales Taxes: 7.65 Total: 65.15' do
        importer = Importer.new(
          '1 imported box of chocolates at 10.00 1 imported bottle of perfume at 47.50'
        )
        data_for_receipt = importer.export_data_for_receipt
        receipt = Receipt.new data_for_receipt
        output = receipt.to_s
        expect(output).to eq('1 imported box of chocolates: 10.50 1 imported bottle of perfume: 54.65 Sales Taxes: 7.65 Total: 65.15')
      end

      it 'Input 3:
          1 imported bottle of perfume at 27.99
          1 bottle of perfume at 18.99 1 packet of headache
          pills at 9.75 1 box of imported chocolates at 11.25
          returns:
          1 imported bottle of perfume: 32.19 1 bottle of perfume: 20.89
          1 packet of headache pills: 9.75 1 imported box of chocolates: 11.85
          Sales Taxes: 6.70 Total: 74.68' do
        importer = Importer.new(
          '1 imported bottle of perfume at 27.99 1 bottle of perfume at 18.99 1 packet of headache pills at 9.75 1 box of imported chocolates at 11.25'
        )
        data_for_receipt = importer.export_data_for_receipt
        receipt = Receipt.new data_for_receipt
        output = receipt.to_s
        expect(output).to eq('1 imported bottle of perfume: 32.19 1 bottle of perfume: 20.89 1 packet of headache pills: 9.75 1 imported box of chocolates: 11.85 Sales Taxes: 6.70 Total: 74.68')
      end
    end
  end
end