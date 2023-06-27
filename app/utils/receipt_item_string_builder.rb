# frozen_string_literal: true

# Builds an string to be used as part
# of the receipt based on an instance of
# PurchaseItem
class ReceiptItemStringBuilder
  DEFAULT_DESCRIPTION = 'no description'
  DEFAULT_QUANTITY = '0'
  DEFAULT_TOTAL_PRICE_WITH_TAXES = '0'

  def self.build(purchase_item)
    return '' if purchase_item.nil?

    description = if purchase_item.description.nil? || purchase_item.description.empty?
                    DEFAULT_DESCRIPTION
                  else
                    purchase_item.description
                  end
    quantity = purchase_item.quantity || DEFAULT_QUANTITY
    total_price_with_taxes = purchase_item.readable_total_price_with_taxes || DEFAULT_TOTAL_PRICE_WITH_TAXES

    "#{quantity} #{description}: #{total_price_with_taxes}"
  end
end
