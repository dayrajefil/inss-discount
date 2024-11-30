# spec/models/address_spec.rb
require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      address = build(:address)
      expect(address).to be_valid
    end

    it 'is invalid without a zip_code' do
      address = build(:address, zip_code: nil)
      address.valid?
      expect(address.errors[:zip_code]).to include('não pode ficar em branco')
    end

    it 'is invalid without a street' do
      address = build(:address, street: nil)
      address.valid?
      expect(address.errors[:street]).to include('não pode ficar em branco')
    end

    it 'is invalid without a number' do
      address = build(:address, number: nil)
      address.valid?
      expect(address.errors[:number]).to include('não pode ficar em branco')
    end

    it 'is invalid without a neighborhood' do
      address = build(:address, neighborhood: nil)
      address.valid?
      expect(address.errors[:neighborhood]).to include('não pode ficar em branco')
    end

    it 'is invalid without a city' do
      address = build(:address, city: nil)
      address.valid?
      expect(address.errors[:city]).to include('não pode ficar em branco')
    end

    it 'is invalid without a state' do
      address = build(:address, state: nil)
      address.valid?
      expect(address.errors[:state]).to include('não pode ficar em branco')
    end

    it 'is invalid with an incorrect zip_code format' do
      address = build(:address, zip_code: '12345-6')
      address.valid?
      expect(address.errors[:zip_code]).to include('deve estar no formato 00000-000')
    end

    it 'is valid with the correct zip_code format' do
      address = build(:address, zip_code: '12345-678')
      expect(address).to be_valid
    end
  end
end
