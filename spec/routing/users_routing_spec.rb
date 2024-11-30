# frozen_string_literal: true

# spec/routing/users_routing_spec.rb
require 'rails_helper'

RSpec.describe 'Users routes', type: :routing do
  it 'routes to #sign_in' do
    expect(get: '/users/sign_in').to route_to('devise/sessions#new')
  end

  it 'routes to #sign_out' do
    expect(delete: '/users/sign_out').to route_to('devise/sessions#destroy')
  end

  it 'routes to #sign_up' do
    expect(get: '/users/sign_up').to route_to('devise/registrations#new')
  end

  it 'routes to #edit' do
    expect(get: '/users/edit').to route_to('devise/registrations#edit')
  end
end
