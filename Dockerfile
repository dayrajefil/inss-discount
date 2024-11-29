FROM ruby:3.3.0

# Instalar dependências do sistema
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  postgresql-client \
  curl \
  gnupg \
  && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
  && apt-get install -y nodejs \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update && apt-get install -y yarn

# Definir diretório de trabalho
WORKDIR /workdir

# Copiar Gemfile e Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Instalar dependências
RUN bundle install

# Instalar o Redis sem confirmação
RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -y redis-server

# Copiar o restante da aplicação
COPY . ./

# Expor a porta
EXPOSE 3000

# Iniciar o servidor Rails
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
