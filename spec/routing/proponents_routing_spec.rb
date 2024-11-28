require 'rails_helper'

RSpec.describe ProponentsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/proponents').to route_to('proponents#index')
    end

    it 'routes to #new' do
      expect(get: '/proponents/new').to route_to('proponents#new')
    end

    it 'routes to #edit' do
      expect(get: '/proponents/1/edit').to route_to('proponents#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/proponents').to route_to('proponents#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/proponents/1').to route_to('proponents#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/proponents/1').to route_to('proponents#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/proponents/1').to route_to('proponents#destroy', id: '1')
    end

    it 'routes to #inss_amount' do
      expect(post: '/proponents/inss_amount').to route_to('proponents#inss_amount')
    end
  end
end
