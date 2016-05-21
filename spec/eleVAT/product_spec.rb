require 'spec_helper'

module EleVAT
  describe Product do
    it 'has a valid constructor' do
      expect { Product.new(1, 'Chocolate', 2.0) }.to_not raise_error
    end

    it 'raise ArgumentError if price is not a float > 0' do
      expect { Product.new(1, 'Chocolate', 0.0) }.to raise_error ArgumentError
    end

    it 'raise ArgumentError if name is not a valid string' do
      expect { Product.new(1, nil, 0.0) }.to raise_error ArgumentError
    end

    it 'raise ArgumentError quantity is an int >= 0' do
      expect { Product.new(0, 'Chocolate', 0.0) }.to raise_error ArgumentError
    end

    describe 'prepare_for_receipt' do
      before(:each) do
        @product = Product.new(1, 'Chocolate', 0.85, false)
        @hash_rappresentation = @product.prepare_for_receipt
      end
      it 'return an hash' do
        expect(@hash_rappresentation.class).to eq(Hash)
      end

      it 'include all the fields' do
        fields = [:name, :quantity, :net_price, :gross_price, :tax, :imported, :taxable]
        @hash_rappresentation.keys == fields
      end
    end

    describe 'for tax free product' do
      before(:each) do
        @product = Product.new(1, 'Chocolate', 0.85, false)
        @product.send(:calculate_tax)
      end
      it 'calculate the gross price' do
        expect(@product.gross_price).to eq 0.85
      end

      it 'calculate the taxes' do
        expect(@product.tax).to eq 0.0
      end
    end

    describe 'for tax free imported product' do
      before(:each) do
        @product = Product.new(1, 'imported chocolates', 10.00, false, true)
        @product.send(:calculate_tax)
      end
      it 'calculate the gross price' do
        expect(@product.gross_price).to eq 10.50
      end

      it 'calculate the taxes' do
        expect(@product.tax).to eq 0.50
      end
    end

    describe 'for taxed product' do
      before(:each) do
        @product = Product.new(1, 'bottle of perfume', 18.99, true, false)
        @product.send(:calculate_tax)
      end
      it 'calculate the gross price' do
        expect(@product.gross_price).to eq 20.89
      end

      it 'calculate the taxes' do
        expect(@product.tax).to eq 1.90
      end
    end

    describe 'for imported taxed product' do
      before(:each) do
        @product = Product.new(1, 'bottle of perfume', 27.99, true, true)
        @product.send(:calculate_tax)
      end
      it 'calculate the gross price' do
        expect(@product.gross_price).to eq 32.19
      end

      it 'calculate the taxes' do
        expect(@product.tax).to eq 4.20
      end
    end

    describe 'for imported taxed product' do
      before(:each) do
        @product = Product.new(2, 'bottle of perfume', 27.99, true, true)
        @product.send(:calculate_tax)
      end
      it 'calculate the gross price' do
        expect(@product.gross_price).to eq 64.38
      end

      it 'calculate the taxes' do
        expect(@product.tax).to eq 8.40
      end
    end
  end
end