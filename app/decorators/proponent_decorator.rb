# frozen_string_literal: true

# ProponentDecorator é uma classe que decora objetos de `Proponent`, oferecendo métodos adicionais
# para exibir os dados de forma formatada na interface do usuário.
#
# Ela inclui métodos para formatar a data de nascimento, o salário e o INSS do proponente, além de
# fornecer métodos auxiliares para exibir os valores sem a unidade monetária.
#
# A classe também inclui um método `actions` para gerar links de edição e exclusão, facilitando a
# interação do usuário com os dados do proponente.
#
class ProponentDecorator < Draper::Decorator
  delegate_all

  def self.header_attributes
    %i[name birthdate phone salary inss discounted_salary address actions]
  end

  def birthdate
    I18n.l(object.birthdate) if object.birthdate.present?
  end

  def salary
    h.number_to_currency(object.salary)
  end

  def inss
    h.number_to_currency(object.inss)
  end

  def discounted_salary
    h.number_to_currency(object.discounted_salary)
  end

  def salary_without_unit
    h.number_to_currency(object.salary, unit: '', delimiter: '.', separator: ',')
  end

  def inss_without_unit
    h.number_to_currency(object.inss, unit: '', delimiter: '.', separator: ',')
  end

  def actions
    edit_link = h.link_to(I18n.t('actions.edit'), h.edit_proponent_path(object), class: 'btn btn-secondary btn-sm')
    delete_link = h.button_to(I18n.t('actions.delete'), object, method: :delete, data: {
                                turbo_confirm: I18n.t('messages.confirm.delete')
                              }, class: 'btn btn-danger btn-sm')

    "#{edit_link} #{delete_link}".html_safe
  end
end
