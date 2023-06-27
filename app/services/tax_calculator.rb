# frozen_string_literal: true

# Returns an adjust value by taxes based
# on the item provided
class TaxCalculator
  IMPORTED_TAG = 'imported'

  def initialize(no_taxes_products)
    @no_taxes_products = no_taxes_products || []
  end

  def calculate(item, value)
    return value if item.nil? || item.empty?

    taxes_percentage = 0

    is_imported = false

    description = if item.start_with?(IMPORTED_TAG)
                    is_imported = true
                    item.split(' ', 2)[1]
                  else
                    item
                  end

    taxes_percentage += 5 if is_imported
    taxes_percentage += 10 unless @no_taxes_products.include?(description)

    raw_taxes = value.to_f * taxes_percentage / 100
    round_up_to_nearest005(raw_taxes)
  end

  private

  def round_up_to_nearest005(value)
    int_ref_value = value * 100
    return value if (int_ref_value % 5).zero?

    to_next5 = 5 - (int_ref_value % 5)

    (int_ref_value + to_next5).to_f / 100
  end
end
