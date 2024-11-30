# frozen_string_literal: true

# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'validations' do
    context 'when username is not provided' do
      it 'is not valid without a username' do
        user.username = nil
        expect(user).not_to be_valid
        expect(user.errors[:username]).to include('não pode ficar em branco')
      end
    end

    context 'when username is not unique' do
      it 'is not valid with a duplicate username' do
        create(:user, username: 'uniqueuser')
        user.username = 'uniqueuser'
        expect(user).not_to be_valid
        expect(user.errors[:username]).to include('já está em uso')
      end
    end

    context 'when username format is invalid' do
      it 'is not valid with invalid characters' do
        user.username = 'invalid@username'
        expect(user).not_to be_valid
        expect(user.errors[:username]).to include('somente letras minúsculas, underscores e pontos são permitidos')
      end
    end

    context 'when username format is valid' do
      it 'is valid with lowercase letters, dots, or underscores' do
        user.username = 'valid.username'
        expect(user).to be_valid

        user.username = 'valid_username'
        expect(user).to be_valid
      end
    end
  end
end
