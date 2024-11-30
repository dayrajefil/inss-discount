# frozen_string_literal: true

# A classe Proponent representa um proponente no sistema. Ela está associada a um endereço
# e contém validações para garantir a presença de informações essenciais como nome, data de nascimento,
# telefone e salário. O formato do telefone também é validado.
#
# A classe permite a criação ou atualização do endereço associado através de atributos aninhados.
#
class Proponent < ApplicationRecord
  belongs_to :address

  validates :name, :birthdate, :phone, :salary, presence: true

  validates :phone, uniqueness: true, format: {
    with: /\A\(\d{2}\) \d{4,5}-\d{4}\z/, message: I18n.t('errors.messages.phone_format')
  }

  accepts_nested_attributes_for :address

  default_scope { order(:created_at) }
end
