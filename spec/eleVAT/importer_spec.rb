require 'spec_helper'

module EleVAT
  describe Importer do
    describe 'import' do
      it 'raise exceprion with invalid input' do
        expect { Importer.new(10) }.to raise_error NotImplementedError
      end

      it 'has at least a valid constructor' do
        importer = Importer.new(
          '1 book at 12.49 1 music CD at 14.99 1 chocolate bar at 0.85'
        )
        expect(importer).to_not be_nil
      end

      describe 'from string' do
        before(:each) do
          @importer = Importer.new(
            '1 book at 12.49 1 music CD at 14.99'\
            ' 1 imported chocolate bar at 0.85'
          )
        end
        it 'one product return an array with one product' do
          expect(@importer.imported_data.size).to eq 3
        end
        it 'the first product name should be book' do
          expect(@importer.imported_data.first.name).to eq 'book'
        end
        it 'the first product price should be 12.49' do
          expect(@importer.imported_data.first.net_price).to eq 12.49
        end
        it 'the third product should be tax free' do
          expect(@importer.imported_data.last.taxable).to eq false
        end
        it 'the third product should be imported' do
          expect(@importer.imported_data.last.imported).to eq true
        end
        it 'return an array of hash after creating data for receipt' do
          data_for_receipt = @importer.export_data_for_receipt
          expect(data_for_receipt.all? { |p| p.class == Hash }).to be true
        end
      end
    end
  end
end