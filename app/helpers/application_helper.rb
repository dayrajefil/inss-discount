# frozen_string_literal: true

# ApplicationHelper contém métodos auxiliares que são usados para facilitar a criação
# de elementos HTML dinâmicos nas views, como botões de submit, títulos de páginas e
# links de ação. Esses métodos ajudam a manter as views mais limpas e reutilizáveis.
#
module ApplicationHelper
  def submit_button(form, title_key = nil)
    content_tag(:div, class: 'd-flex justify-content-end my-2') do
      form.submit(title_key || t('actions.save'), class: 'btn btn-secondary')
    end
  end

  def title_index(title_key, *action_buttons)
    content_tag(:div, class: 'd-flex justify-content-between align-items-center') do
      concat(content_tag(:h1, t(title_key), class: 'm-0'))
      concat(content_tag(:div, class: 'd-flex flex-column flex-md-row justify-content-end align-items-end') do
        action_buttons.each do |action|
          concat(link_to(action[:label], action[:path], class: 'btn btn-secondary mx-2 mb-2 mb-md-0 mr-md-2'))
        end
      end)
    end + tag.br
  end

  def title_form(title_key, back_button_path = nil, save_button_path = nil)
    content_tag(:div, class: 'd-flex justify-content-between align-items-center mb-3') do
      concat(content_tag(:h1, t(title_key), class: 'd-inline'))
      concat(content_tag(:div, class: 'd-inline') do
        concat(link_to('<', back_button_path, class: 'btn btn-secondary')) if back_button_path.present?
        concat(link_to('Save', save_button_path, class: 'btn btn-primary ml-2')) if save_button_path.present?
      end)
    end + tag.br
  end
end
