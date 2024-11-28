class Proponent < ApplicationRecord
  belongs_to :address

  validates :name, :birthdate, :phone, :salary, presence: true

  validates :phone, uniqueness: true, format: {
    with: /\A\(\d{2}\) \d{4,5}-\d{4}\z/, message: I18n.t('errors.messages.phone_format')
  }

  accepts_nested_attributes_for :address

  default_scope { order(:created_at) }
end
