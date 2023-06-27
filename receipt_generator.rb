# frozen_string_literal: true

require 'yaml'
require_relative 'app/models/receipt'
require_relative 'app/services/tax_calculator'
require_relative 'app/utils/purchase_item_parser'
require_relative 'app/utils/receipt_item_string_builder'

# Generates te receipt details
# based on the provided items
class ReceiptGenerator
  def self.run(file_name)
    receipt = Receipt.new

    raw_no_taxes_products = YAML.load_file('config/no_taxes_products.yml')
    no_taxes_products = raw_no_taxes_products['BOOKS']
                        .concat(raw_no_taxes_products['FOOD'])
                        .concat(raw_no_taxes_products['MEDICAL_PRODUCTS'])

    tax_calculator = TaxCalculator.new(no_taxes_products)

    f = File.open("seed/#{file_name}", 'r')
    f.each_line do |string_item|
      purchase_item = PurchaseItemParser.new(tax_calculator).parse(string_item)

      receipt.add_item(purchase_item)
      puts ReceiptItemStringBuilder.build(purchase_item)
    end

    puts "Sale Taxes: #{receipt.readable_sale_taxes}"
    puts "Total: #{receipt.readable_total}"
  end
end

ReceiptGenerator.run(ARGV[0] || 'input_1.txt')
