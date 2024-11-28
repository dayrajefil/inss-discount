# spec/helpers/application_helper_spec.rb
require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#submit_button' do
    let(:form) { double('Form', submit: '<button type="submit" class="btn btn-secondary">Save</button>'.html_safe) }

    it 'renders a submit button with correct classes and text' do
      allow(helper).to receive(:t).with('actions.save').and_return('Save')

      result = helper.submit_button(form)

      expect(result).to include('<div class="d-flex justify-content-end my-2">')
      expect(result).to include('<button type="submit" class="btn btn-secondary">Save</button>')
      expect(result).to include('Save')
    end
  end

  describe '#title_index' do
    it 'renders the title and action buttons correctly' do
      action_buttons = [{ label: 'New', path: '/new' }]
      allow(helper).to receive(:t).with('proponents.index').and_return('Proponents')

      result = helper.title_index('proponents.index', *action_buttons)

      expect(result).to include('<h1 class="m-0">Proponents</h1>')
      expect(result).to include('<a class="btn btn-secondary mx-2 mb-2 mb-md-0 mr-md-2" href="/new">New</a>')
    end

    it 'renders title without action buttons' do
      allow(helper).to receive(:t).with('proponents.index').and_return('Proponents')

      result = helper.title_index('proponents.index')

      expect(result).to include('<h1 class="m-0">Proponents</h1>')
      expect(result).not_to include('btn btn-secondary')
    end
  end

  describe '#title_form' do
    it 'renders title, back button, and save button correctly' do
      allow(helper).to receive(:t).with('proponents.new').and_return('New Proponent')

      result = helper.title_form('proponents.new', '/back', '/save')

      expect(result).to include('<h1 class="d-inline">New Proponent</h1>')
      expect(result).to include('<a class="btn btn-secondary" href="/back">&lt;</a>')
      expect(result).to include('<a class="btn btn-primary ml-2" href="/save">Save</a>')
    end

    it 'renders title and only back button if provided' do
      allow(helper).to receive(:t).with('proponents.new').and_return('New Proponent')

      result = helper.title_form('proponents.new', '/back')

      expect(result).to include('<h1 class="d-inline">New Proponent</h1>')
      expect(result).to include('<a class="btn btn-secondary" href="/back">&lt;</a>')
      expect(result).not_to include('Save')
    end

    it 'renders title and only save button if provided' do
      allow(helper).to receive(:t).with('proponents.new').and_return('New Proponent')

      result = helper.title_form('proponents.new', nil, '/save')

      expect(result).to include('<h1 class="d-inline">New Proponent</h1>')
      expect(result).to include('<a class="btn btn-primary ml-2" href="/save">Save</a>')
    end
  end
end
