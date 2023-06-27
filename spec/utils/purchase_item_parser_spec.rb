# frozen_string_literal: true

require_relative '../../app/utils/purchase_item_parser'
require_relative '../../app/errors/parse_string_item_error'

RSpec.describe PurchaseItemParser do
  describe '.parse' do
    subject { described_class.new(nil).parse(item) }

    context 'when item is a valid purchase item string' do
      let(:item) { '2 book at 12.49' }

      it { is_expected.to be_a PurchaseItem }
      it { is_expected.to have_attributes({ quantity: 2, description: 'book', unit_price: 12.49 }) }
    end

    context 'when item contains an imported description' do
      let(:item) { '1 imported bottle of perfume at 27.99' }

      it { is_expected.to be_a PurchaseItem }
      it { is_expected.to have_attributes({ quantity: 1, description: 'imported bottle of perfume', unit_price: 27.99 }) }
    end

    context 'when item has an "at" string as part of its description' do
      let(:item) { '5 stickers with cat faces at 9.55' }

      it { is_expected.to be_a PurchaseItem }
      it { is_expected.to have_attributes({ quantity: 5, description: 'stickers with cat faces', unit_price: 9.55 }) }
    end

    context 'when item has a unit price with more than 2 decimals' do
      let(:item) { '5 stickers with cat faces at 9.55578952' }

      it { is_expected.to be_a PurchaseItem }
      it { is_expected.to have_attributes({ quantity: 5, description: 'stickers with cat faces', unit_price: 9.55578952 }) }
    end

    context 'when item is nil' do
      let(:item) { nil }

      it { is_expected.to eq(nil) }
    end

    context 'when item is empty string' do
      let(:item) { '' }

      it { expect { subject }.to raise_error(Errors::ParseStringItemError, 'Item is blank') }
    end

    context 'when item is an invalid purchase item string' do
      let(:item) { 'This is an invalid purchase item string' }

      it { expect { subject }.to raise_error(Errors::ParseStringItemError, 'Item is an invalid string') }
    end

    context 'when item has more than on "at" string' do
      let(:item) { '2 books at the library at 30.54' }

      it { expect { subject }.to raise_error(Errors::ParseStringItemError, 'Item is an invalid string') }
    end

    context 'when item has an invalid string as unit price' do
      let(:item) { '7 book at Invalid' }

      it { expect { subject }.to raise_error(Errors::ParseStringItemError, 'Invalid Unit Price') }
    end

    context 'when item has an invalid string as quantity' do
      let(:item) { 'Invalid book at 9.55' }

      it { expect { subject }.to raise_error(Errors::ParseStringItemError, 'Invalid Quantity') }
    end
  end
end
