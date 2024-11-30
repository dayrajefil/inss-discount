# frozen_string_literal: true

# spec/controllers/proponents_controller_spec.rb
require 'rails_helper'

RSpec.describe ProponentsController, type: :controller do
  let(:valid_attributes) do
    {
      name: 'John Doe',
      birthdate: '1990-01-01',
      phone: '(11) 98765-4321',
      salary: '1.000,00',
      address_attributes: {
        zip_code: '12345-678',
        street: 'Rua ABC',
        number: '123',
        neighborhood: 'Centro',
        city: 'São Paulo',
        state: 'SP'
      }
    }
  end

  let(:invalid_attributes) do
    {
      name: nil,
      birthdate: '1990-01-01',
      phone: '(11) 98765-4321',
      salary: '1.000,00',
      address_attributes: {
        zip_code: '12345-678',
        street: 'Rua ABC',
        number: '123',
        neighborhood: 'Centro',
        city: 'São Paulo',
        state: 'SP'
      }
    }
  end

  let(:proponent) { create(:proponent) }

  describe 'GET #index' do
    it 'assigns @proponents and renders the index template' do
      create(:proponent)
      get :index
      expect(assigns(:proponents)).to eq(Proponent.all.page(1).per(5))
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'assigns a new proponent and builds an address' do
      get :new
      expect(assigns(:proponent)).to be_a_new(Proponent)
      expect(assigns(:proponent).address).to be_a_new(Address)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Proponent and redirects to proponents path' do
        expect do
          post :create, params: { proponent: valid_attributes }
        end.to change(Proponent, :count).by(1)
        expect(response).to redirect_to(proponents_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Proponent and renders the new page' do
        expect do
          post :create, params: { proponent: invalid_attributes }
        end.to change(Proponent, :count).by(0)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested proponent to @proponent' do
      get :edit, params: { id: proponent.id }
      expect(assigns(:proponent)).to eq(proponent)
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH/PUT #update' do
    context 'with valid parameters' do
      let(:new_attributes) { { name: 'Jane Doe' } }

      it 'updates the requested proponent and redirects to proponents path' do
        patch :update, params: { id: proponent.id, proponent: new_attributes }
        proponent.reload
        expect(proponent.name).to eq('Jane Doe')
        expect(response).to redirect_to(proponents_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not update the proponent and re-renders the edit template' do
        patch :update, params: { id: proponent.id, proponent: invalid_attributes }
        proponent.reload
        expect(proponent.name).not_to eq(nil)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested proponent and redirects to proponents path' do
      proponent_to_destroy = create(:proponent)
      expect do
        delete :destroy, params: { id: proponent_to_destroy.id }
      end.to change(Proponent, :count).by(-1)
      expect(response).to redirect_to(proponents_path)
    end
  end

  describe 'POST #inss_amount' do
    context 'when salary is valid' do
      let(:valid_salary) { '5000,00' }
      let(:expected_inss_amount) { InssCalculator.calculate(valid_salary.to_f) }

      before do
        post :inss_amount, params: { proponent: { salary: valid_salary } }
      end

      it 'returns the correct INSS amount in JSON format' do
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to eq({ 'inss_amount' => ' 558,95' })
      end
    end
  end
end
