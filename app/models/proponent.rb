class Proponent < ApplicationRecord
  belongs_to :address

  validates :name, :birthdate, :phone, :salary, presence: true

  validates :salary, numericality: {
    greater_than_or_equal_to: 1412,
    message: I18n.t('errors.messages.greater_than_or_equal_to', count: 'R$ 1.412,00')
  }

  validates :phone, uniqueness: true, format: {
    with: /\A\(\d{2}\) \d{4,5}-\d{4}\z/, message: I18n.t('errors.messages.phone_format')
  }

  accepts_nested_attributes_for :address

  default_scope { order(:created_at) }
end
