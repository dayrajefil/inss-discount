# spec/controllers/reports_controller_spec.rb
require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  describe 'GET #proponent_salary' do
    before do
      create(:proponent, salary: 500.00)
      create(:proponent, salary: 1500.00)
      create(:proponent, salary: 2500.00)
      create(:proponent, salary: 4000.00)
      create(:proponent, salary: 6000.00)
    end

    it 'correctly groups bidders by salary range' do
      get :proponent_salary

      expect(assigns(:salary_groups)).to eq([
                                              { label: 'Até R$ 1.045,00', count: 1 },
                                              { label: 'De R$ 1.045,01 a R$ 2.089,60', count: 1 },
                                              { label: 'De R$ 2.089,61 até R$ 3.134,40', count: 1 },
                                              { label: 'De R$ 3.134,41 até R$ 6.101,06', count: 2 },
                                              { label: 'Acima de R$ 6.101,06', count: 0 }
                                            ])
    end
  end
end
