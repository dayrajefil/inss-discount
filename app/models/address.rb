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
