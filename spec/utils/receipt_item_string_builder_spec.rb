# frozen_string_literal: true

require_relative '../../app/utils/receipt_item_string_builder'

RSpec.describe ReceiptItemStringBuilder do
  describe '.build' do
    subject { described_class.build(item) }
    let(:tax_calculator) { DummyTaxCalator.new }

    before do
      # Ensure we are not executing logic in PurchaseItem
      allow_any_instance_of(PurchaseItem).to receive(:readable_total_price_with_taxes).and_return('20')
    end

    context 'when item is a valid purchase item' do
      let(:item) do
        PurchaseItem.new(quantity: 2, description: 'book', unit_price: 9.25)
      end

      it { is_expected.to eq('2 book: 20') }
    end

    context 'when item has nil as quantity' do
      let(:item) do
        PurchaseItem.new(quantity: nil, description: 'book', unit_price: 9.25)
      end

      it { is_expected.to eq('0 book: 20') }
    end

    context 'when item has nil as description' do
      let(:item) do
        PurchaseItem.new(quantity: 13, description: nil, unit_price: 9.25)
      end

      it { is_expected.to eq('13 no description: 20') }
    end

    context 'when item has empty string as description' do
      let(:item) do
        PurchaseItem.new(quantity: 12, description: '', unit_price: 9.25)
      end

      it { is_expected.to eq('12 no description: 20') }
    end

    context 'when item has nil as readable_total_price_with_taxes' do
      before do
        # Ensure we are not executing logic in PurchaseItem
        allow_any_instance_of(PurchaseItem).to receive(:readable_total_price_with_taxes).and_return(nil)
      end

      let(:item) do
        PurchaseItem.new(quantity: 17, description: 'book', unit_price: 9.25)
      end

      it { is_expected.to eq('17 book: 0') }
    end

    context 'when item is nil' do
      let(:item) { nil }

      it { is_expected.to eq('') }
    end
  end
end
