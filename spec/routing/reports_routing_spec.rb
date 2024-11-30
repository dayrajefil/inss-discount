# frozen_string_literal: true

# spec/routing/reports_routing_spec.rb
require 'rails_helper'

RSpec.describe 'Reports routes', type: :routing do
  it 'routes to #proponent_salary' do
    expect(get: '/reports/proponent_salary').to route_to('reports#proponent_salary')
  end
end
