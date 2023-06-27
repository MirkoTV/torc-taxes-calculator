# frozen_string_literal: true

require_relative '../../app/services/tax_calculator'

RSpec.describe TaxCalculator do
  describe '#calculate' do
    subject { described_class.new(no_taxes_products).calculate(item, value) }
    let(:no_taxes_products) do
      [
        'book',
        'packet of headache pills',
        'chocolate bar',
        'boxes of chocolates'
      ]
    end

    context 'when item is a medical product' do
      let(:item) { 'packet of headache pills' }
      let(:value) { 9.75 }

      it 'returns no taxes' do
        is_expected.to be(0.0)
      end
    end

    context 'when item is neither a book nor food mor a medical product' do
      let(:item) { 'music CD' }
      let(:value) { 14.99 }

      it 'returns 10% of taxes' do
        is_expected.to be(1.5)
      end
    end

    context 'when item is a book' do
      let(:item) { 'book' }
      let(:value) { 12.49 }

      it 'returns no taxes' do
        is_expected.to be(0.0)
      end
    end

    context 'when item is food' do
      let(:item) { 'chocolate bar' }
      let(:value) { 0.85 }

      it 'returns no taxes' do
        is_expected.to be(0.0)
      end
    end

    context 'when item is a medical product' do
      let(:item) { 'packet of headache pills' }
      let(:value) { 9.75 }

      it 'returns no taxes' do
        is_expected.to be(0.0)
      end
    end

    context 'when item is a medical product' do
      let(:item) { 'packet of headache pills' }
      let(:value) { 9.75 }

      it 'returns no taxes' do
        is_expected.to be(0.0)
      end
    end

    context 'when item is an imported book' do
      let(:item) { 'imported book' }
      let(:value) { 10 }

      it 'returns 5% of taxes' do
        is_expected.to be(0.5)
      end
    end

    context 'when item is imported food' do
      let(:item) { 'imported boxes of chocolates' }
      let(:value) { 11.25 }

      it 'returns 5% of taxes' do
        is_expected.to be(0.6)
      end
    end

    context 'when item is an imported medical product' do
      let(:item) { 'imported packet of headache pills' }
      let(:value) { 11.25 }

      it 'returns 5% of taxes' do
        is_expected.to be(0.6)
      end
    end

    context 'when item is imported and it is neither a book nor food mor a medical product' do
      let(:item) { 'imported bottle of perfume' }
      let(:value) { 10 }

      it 'returns 15% of taxes' do
        is_expected.to be(1.5)
      end
    end
  end
end
