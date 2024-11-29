# spec/models/proponent_spec.rb
require 'rails_helper'

RSpec.describe Proponent, type: :model do
  describe 'associations' do
    it 'belongs to an address' do
      proponent = build(:proponent)
      expect(proponent.address).to be_a(Address)
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      proponent = build(:proponent)
      expect(proponent).to be_valid
    end

    it 'is invalid without a name' do
      proponent = build(:proponent, name: nil)
      proponent.valid?
      expect(proponent.errors[:name]).to include('não pode ficar em branco')
    end

    it 'is invalid without a birthdate' do
      proponent = build(:proponent, birthdate: nil)
      proponent.valid?
      expect(proponent.errors[:birthdate]).to include('não pode ficar em branco')
    end

    it 'is invalid without a phone' do
      proponent = build(:proponent, phone: nil)
      proponent.valid?
      expect(proponent.errors[:phone]).to include('não pode ficar em branco')
    end

    it 'is invalid without a salary' do
      proponent = build(:proponent, salary: nil)
      proponent.valid?
      expect(proponent.errors[:salary]).to include('não pode ficar em branco')
    end

    it 'is invalid with an incorrect phone format' do
      proponent = build(:proponent, phone: '1234567890')
      proponent.valid?
      expect(proponent.errors[:phone]).to include('deve ser um número válido')
    end

    it 'is valid with a correctly formatted phone' do
      proponent = build(:proponent, phone: '(11) 12345-6789')
      expect(proponent).to be_valid
    end

    it 'is invalid with a duplicate phone' do
      create(:proponent, phone: '(11) 12345-6789')
      proponent = build(:proponent, phone: '(11) 12345-6789')
      proponent.valid?
      expect(proponent.errors[:phone]).to include('já está em uso')
    end
  end

  describe 'nested attributes for address' do
    it 'allows nested attributes for address' do
      proponent = Proponent.create!(
        name: 'John Doe',
        birthdate: '1990-01-01',
        phone: '(11) 12345-6789',
        salary: 5000.00,
        address_attributes: {
          street: 'Rua A',
          number: '123',
          neighborhood: 'Centro',
          city: 'São Paulo',
          state: 'SP',
          zip_code: '12345-678'
        }
      )

      expect(proponent.address).to be_persisted
      expect(proponent.address.street).to eq('Rua A')
    end
  end

  describe 'scopes' do
    before do
      Proponent.destroy_all if Rails.env.test?
    end

    it 'orders by created_at by default' do
      proponent1 = create(:proponent, created_at: 2.days.ago)
      proponent2 = create(:proponent, created_at: 1.day.ago)

      expect(Proponent.all).to eq([proponent1, proponent2])
    end
  end
end
