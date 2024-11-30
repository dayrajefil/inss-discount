# frozen_string_literal: true

# A classe User herda de ApplicationRecord e integra-se com o sistema de autenticação
# fornecido pelo Devise. Além disso, define validações para o campo `username`, garantindo
# que ele seja único e siga um formato específico (somente letras minúsculas, pontos e underlines).
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true
  validates :username,
            format: {
              with: /\A[a-z._]+\z/,
              message: :username_format
            }
end
