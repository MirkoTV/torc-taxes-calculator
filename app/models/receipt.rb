# frozen_string_literal: true

# Describes a receipt
class Receipt
  def initialize
    @purchase_items = []
  end

  def add_item(new_item)
    @purchase_items << new_item
  end

  def readable_total
    format('%.2f', total.round(2))
  end

  def readable_sale_taxes
    format('%.2f', sale_taxes.round(2))
  end

  private

  def total
    @purchase_items.map(&:total_price_with_taxes).sum
  end

  def sale_taxes
    @purchase_items.map(&:sale_taxes).sum
  end
end
