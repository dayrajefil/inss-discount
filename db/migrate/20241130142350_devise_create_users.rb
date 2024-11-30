# frozen_string_literal: true

# DeviseCreateUsers é uma migração responsável por criar a tabela `users` no banco de dados
# para armazenar informações relacionadas à autenticação de usuários usando o Devise.
# A tabela inclui campos para username, o e-mail (`email`), senha criptografada (`encrypted_password`),
# token de recuperação de senha (`reset_password_token`),
# e a data e hora do último envio de token de recuperação (`reset_password_sent_at`).
# Além disso, há um campo para lembrar o usuário (`remember_created_at`),
# além dos campos padrão de timestamps (`created_at` e `updated_at`).
# Também são adicionados índices únicos para os campos `email` e `reset_password_token`
# para melhorar a performance das buscas.
#
class DeviseCreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string   :username, null: false
      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_index :users, %i[email username], unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
