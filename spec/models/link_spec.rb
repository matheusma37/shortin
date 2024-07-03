# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Link, type: :model do
  context 'validations' do
    context 'presence' do
      subject(:link) { build(:link, original_url: nil) }

      it 'validates presence' do
        expect(link).not_to be_valid
        expect(link.errors.key?(:original_url)).to be_truthy
        expect(link.errors.messages_for(:original_url)).to include("can't be blank")
      end

      it 'validates presence' do
        expect(link).not_to be_valid
        expect(link.errors.key?(:code)).to be_truthy
        expect(link.errors.messages_for(:code)).to include("can't be blank")
      end
    end

    context 'uniqueness' do
      subject(:link) { build(:link) }

      before do
        allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('test1234')
        create(:link)
      end

      it 'validates uniqueness' do
        expect(link).not_to be_valid
        expect(link.errors.key?(:original_url)).to be_truthy
        expect(link.errors.messages_for(:original_url)).to include('has already been taken')
      end

      it 'validates uniqueness' do
        expect(link).not_to be_valid
        expect(link.errors.key?(:code)).to be_truthy
        expect(link.errors.messages_for(:code)).to include('has already been taken')
      end
    end
  end

  context 'callbacks' do
    context 'fill_code' do
      it 'sets the correct value' do
        link = build(:link, original_url: 'test.com')
        link.validate

        expect(link.original_url).to eq('test.com')
      end

      it 'downcase caracters' do
        link = build(:link, original_url: 'TEST.COM')
        link.validate

        expect(link.original_url).to eq('test.com')
      end
    end

    context 'sanitize_original_url' do
      context 'with empty original_url' do
        it 'does not set a value' do
          link = build(:link, original_url: '')
          link.validate

          expect(link.code).to eq(nil)
        end
      end

      context 'with nil original_url' do
        it 'does not set a value' do
          link = build(:link, original_url: nil)
          link.validate

          expect(link.code).to eq(nil)
        end
      end

      it 'downcase caracters' do
        link = build(:link, original_url: 'test.com')
        link.validate

        expect(link.code).to be_present
        expect(link.code.size).to eq(8)
      end
    end
  end
end
