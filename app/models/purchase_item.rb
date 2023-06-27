# frozen_string_literal: true

# Describes a purchase item
class PurchaseItem
  attr_reader :quantity, :description, :unit_price

  def initialize(quantity:, description:, unit_price:, tax_calculator: nil)
    @quantity = quantity
    @description = description
    @unit_price = unit_price
    @tax_calculator = tax_calculator
  end

  def readable_total_price_with_taxes
    format('%.2f', total_price_with_taxes.round(2))
  end

  def total_price_with_taxes
    total_price + sale_taxes
  end

  def sale_taxes
    sale_taxes_per_item * quantity
  end

  private

  def total_price
    (unit_price * quantity)
  end

  def sale_taxes_per_item
    raise StandardError, 'no tax_calculator set up' if @tax_calculator.nil?

    @tax_calculator.calculate(description, unit_price)
  end
end
