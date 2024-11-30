# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      render plain: 'Test'
    end
  end

  describe 'layout selection' do
    context 'when user is signed in' do
      before do
        allow(controller).to receive(:user_signed_in?).and_return(true)
      end

      it 'uses the application layout' do
        expect(controller.send(:set_layout)).to eq('application')
      end
    end

    context 'when user is not signed in' do
      before do
        allow(controller).to receive(:user_signed_in?).and_return(false)
      end

      it 'uses the guest layout' do
        expect(controller.send(:set_layout)).to eq('guest')
      end
    end
  end
end
