FROM ruby:3.3.0

# Instalar dependências do sistema
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Definir diretório de trabalho
WORKDIR /workdir

# Copiar Gemfile e Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Instalar dependências
RUN bundle install

# Copiar o restante da aplicação
COPY . ./

# Expor a porta
EXPOSE 3000

# Iniciar o servidor Rails
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
