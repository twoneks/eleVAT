# EleVAT

This gem is a simple receipts creator. It allow you to calculate the amount of taxes and the amount of the total price for a list of products.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'eleVAT'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install eleVAT

## Usage

Configure the tax rates, the rounding precision and the list of tax free items

```ruby
require 'eleVAT'

EleVAT.configure do |config|
  # Rate for all the items except for the items included in the tax free item
  # list
  config.basic_tax_rate = 10
  # Rate for the imported items
  config.import_tax_rate = 5
  # list of tax free items
  config.tax_free_items = %w(chocolate chocolates pills book)
  # Tax amount will be rounded up to the nearest rounding precision value
  config.rounding_precision = 0.05
end
```

Use the `EleVAT::Importer` to import products and the `EleVAT::Recipt` to calculate the amounts.
```ruby
# For each product the string pattern have to be '$quantity $name at $net_price'
importer = Importer.new(
  '1 imported box of chocolates at 10.00 1 imported bottle of perfume at 47.50'
)
data_for_receipt = importer.export_data_for_receipt
receipt = Receipt.new data_for_receipt
```
You can calculate the the amounts using the following `receipt.calculate_total` and `receipt.calculate_taxes` and access the value through `receipt.total_amount`
and `receipt.taxes`. You can also access the products list `receipt.products`.

If you don't need to use the importer you can create manually the products and add them to the receipt after prepareing them.

```ruby
product = Product.new(1, 'Chocolate', 2.0, taxable = true, imported = false)
receipt.add(product.prepare_for_receipt)
# or
product_2 = Product.new(1, 'Beer', 5.0).prepare_for_receipt
product_3 = Product.new(1, 'Lemon', 2.0).prepare_for_receipt
receipt.add([product_2, product_3])
```

Use `receipt.to_s` to view the printable receipt.

## TO DO
1. Handle the currencies in cents instead of Float to increase the precision.
2. Implement the importer function to precess xls file
3. Implement the function receipt `to_xls`
4. Implement the importer function to precess csv file
5. Implement the function receipt `to_csv`

## Contributing

1. Fork it ( https://github.com/[my-github-username]/eleVAT/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
