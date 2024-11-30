# spec/decorators/proponent_decorator_spec.rb
require 'rails_helper'

RSpec.describe ProponentDecorator, type: :decorator do
  let(:proponent) { create(:proponent, id: 999) }
  let(:decorated_proponent) { proponent.decorate }

  describe '.header_attributes' do
    it 'returns the correct list of attributes' do
      expected_attributes = %i[name birthdate phone salary inss discounted_salary address actions]
      expect(ProponentDecorator.header_attributes).to eq(expected_attributes)
    end
  end

  describe '#birthdate' do
    context 'when birthdate is present' do
      it 'returns formatted birthdate' do
        proponent.update(birthdate: '1980-01-01')
        expect(decorated_proponent.birthdate).to eq('01/01/1980')
      end
    end

    context 'when birthdate is nil' do
      it 'returns nil' do
        proponent.update(birthdate: nil)
        expect(decorated_proponent.birthdate).to be_nil
      end
    end
  end

  describe '#salary' do
    it 'returns salary with currency format' do
      proponent.update(salary: 1000)
      expect(decorated_proponent.salary).to eq('R$ 1.000,00')
    end
  end

  describe '#inss' do
    it 'returns inss with currency format' do
      proponent.update(inss: 100)
      expect(decorated_proponent.inss).to eq('R$ 100,00')
    end
  end

  describe '#discounted_salary' do
    it 'returns discounted_salary with currency format' do
      proponent.update(discounted_salary: 900)
      expect(decorated_proponent.discounted_salary).to eq('R$ 900,00')
    end
  end

  describe '#salary_without_unit' do
    it 'returns salary without currency unit' do
      proponent.update(salary: 1000)
      expect(decorated_proponent.salary_without_unit).to eq(' 1.000,00')
    end
  end

  describe '#inss_without_unit' do
    it 'returns INSS without currency unit' do
      proponent.update(inss: 100)
      expect(decorated_proponent.inss_without_unit).to eq(' 100,00')
    end
  end

  describe '#actions' do
    it 'returns the correct edit and delete links' do
      edit_link = '<a class="btn btn-secondary btn-sm" href="/proponents/999/edit">Editar</a>'
      delete_link = '<form class="button_to" method="post" action="/proponents/999"><input type="hidden" name="_method" value="delete" autocomplete="off" /><button data-turbo-confirm="Tem certeza que quer deletar esse registro?" class="btn btn-danger btn-sm" type="submit">Deletar</button></form>'

      expect(decorated_proponent.actions).to eq("#{edit_link} #{delete_link}")
    end
  end
end
