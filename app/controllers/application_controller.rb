# frozen_string_literal: true

# ApplicationController é a classe base para todos os controladores da aplicação.
# Ela define o layout a ser utilizado nas páginas, dependendo do estado de autenticação do usuário.
# O método `set_layout` verifica se o usuário está autenticado (com `user_signed_in?`).
# Se o usuário estiver logado, o layout 'application' será utilizado. Caso contrário, o layout 'guest' será usado.
#
class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  layout :set_layout

  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def set_layout
    user_signed_in? ? 'application' : 'guest'
  end

  def configure_permitted_parameters
    # Adiciona o username durante o registro
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])

    # Adiciona o username durante a atualização do perfil
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
