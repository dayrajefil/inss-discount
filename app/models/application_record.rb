# frozen_string_literal: true

# ApplicationRecord é a classe base para todos os modelos do sistema.
# Ela herda de ActiveRecord::Base e permite o compartilhamento de comportamentos
# comuns entre os modelos.
#
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
