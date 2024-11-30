# frozen_string_literal: true

# spec/requests/proponents_spec.rb
require 'rails_helper'

RSpec.describe 'Proponents', type: :request do
  let!(:proponent1) { create(:proponent) }
  let!(:proponent2) { create(:proponent) }

  describe 'GET /index' do
    it 'returns a successful response' do
      get proponents_path
      expect(response).to be_successful
    end

    it 'returns the correct number of proponents' do
      get proponents_path
      expect(assigns(:proponents).count).to eq(2)
    end
  end

  describe 'GET /new' do
    it 'returns a successful response' do
      get new_proponent_path
      expect(response).to be_successful
    end

    it 'initializes a new proponent with an address' do
      get new_proponent_path
      expect(assigns(:proponent).address).to be_a_new(Address)
    end
  end

  describe 'POST /create' do
    context 'with valid attributes' do
      it 'creates a new proponent and redirects to index' do
        proponent_params = {
          proponent: {
            name: 'John Doe',
            birthdate: '1990-01-01',
            phone: '(11) 12345-6789',
            salary: '5000.00',
            address_attributes: {
              street: 'Rua A',
              number: '123',
              neighborhood: 'Centro',
              city: 'São Paulo',
              state: 'SP',
              zip_code: '12345-678'
            }
          }
        }

        expect do
          post proponents_path, params: proponent_params
        end.to change(Proponent, :count).by(1)

        expect(response).to redirect_to(proponents_path)
        expect(flash[:notice]).to eq(I18n.t('proponents.notices.create'))
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new proponent and renders the new template' do
        proponent_params = {
          proponent: {
            name: '',
            birthdate: '1990-01-01',
            phone: '(11) 12345-6789',
            salary: '5000.00',
            address_attributes: {
              street: 'Rua A',
              number: '123',
              neighborhood: 'Centro',
              city: 'São Paulo',
              state: 'SP',
              zip_code: '12345-678'
            }
          }
        }

        expect do
          post proponents_path, params: proponent_params
        end.not_to change(Proponent, :count)

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET /edit' do
    let!(:proponent) { create(:proponent) }

    it 'returns a successful response' do
      get edit_proponent_path(proponent)
      expect(response).to be_successful
    end

    it 'assigns the correct proponent' do
      get edit_proponent_path(proponent)
      expect(assigns(:proponent)).to eq(proponent)
    end
  end

  describe 'PATCH /update' do
    let!(:proponent) { create(:proponent) }

    it 'updates the proponent and redirects to the index' do
      updated_params = {
        proponent: {
          name: 'Jane Doe',
          birthdate: '1992-05-12',
          phone: '(11) 98765-4321',
          salary: '6000.00'
        }
      }

      patch proponent_path(proponent), params: updated_params
      proponent.reload

      expect(proponent.name).to eq('Jane Doe')
      expect(response).to redirect_to(proponents_path)
      expect(flash[:notice]).to eq(I18n.t('proponents.notices.update'))
    end

    context 'with invalid attributes' do
      it 'does not update the proponent and renders the edit template' do
        invalid_params = {
          proponent: {
            name: '',
            birthdate: '1992-05-12',
            phone: '(11) 98765-4321',
            salary: '6000.00'
          }
        }

        patch proponent_path(proponent), params: invalid_params
        proponent.reload

        expect(proponent.name).not_to eq('')
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:proponent) { create(:proponent) }

    it 'destroys the proponent and redirects to the index' do
      expect do
        delete proponent_path(proponent)
      end.to change(Proponent, :count).by(-1)

      expect(response).to redirect_to(proponents_path)
      expect(flash[:notice]).to eq(I18n.t('proponents.notices.destroy'))
    end
  end
end
