# frozen_string_literal: true

require_relative '../errors/parse_string_item_error'
require_relative '../models/purchase_item'

# Receives a purchase item string
# and parses the information inside of it
class PurchaseItemParser
  def initialize(tax_calculator)
    @tax_calculator = tax_calculator
  end

  def parse(item)
    return nil if item.nil?
    raise Errors::ParseStringItemError.new, 'Item is blank' if item == ''

    qty_with_description_and_price = item.split(' at ')

    unless qty_with_description_and_price.length == 2
      raise Errors::ParseStringItemError.new, 'Item is an invalid string'
    end

    qty_with_description = qty_with_description_and_price[0]

    begin
      unit_price = Float(qty_with_description_and_price[1])
    rescue ArgumentError
      raise Errors::ParseStringItemError.new, 'Invalid Unit Price'
    end

    qty_and_description = qty_with_description.split(' ', 2)

    begin
      quantity = Integer(qty_and_description[0])
    rescue ArgumentError
      raise Errors::ParseStringItemError.new, 'Invalid Quantity'
    end

    description = qty_and_description[1]

    PurchaseItem.new(
      quantity: quantity,
      description: description,
      unit_price: unit_price,
      tax_calculator: @tax_calculator
    )
  end
end
