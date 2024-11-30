# frozen_string_literal: true

# A classe Address representa um endereço no sistema, com atributos como
# código postal (zip_code), rua (street), número (number), bairro (neighborhood),
# cidade (city) e estado (state).
#
# A classe estabelece um relacionamento de "um para muitos" com a classe Proponent,
# indicando que um endereço pode ser associado a vários proponentes.
#
# Validações são aplicadas para garantir que os campos essenciais estejam presentes,
# e o formato do `zip_code` deve seguir o padrão `XXXXX-XXX`.
#
# O método `to_s` retorna uma string formatada representando o endereço de forma legível.
#
class Address < ApplicationRecord
  has_many :proponents

  validates :zip_code, :street, :number, :neighborhood, :city, :state, presence: true

  validates :zip_code, format: {
    with: /\A\d{5}-\d{3}\z/, message: I18n.t('errors.messages.zip_code_format')
  }, allow_blank: true

  def to_s
    "#{street}, #{number}, #{city}/#{state} - #{zip_code}"
  end
end
