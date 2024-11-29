# inss-discount README

O projeto **inss-discount** é uma aplicação Rails para cálculo e gerenciamento de descontos do INSS. Ele utiliza o PostgreSQL como banco de dados e o Redis para gerenciamento de filas de trabalho com o Sidekiq. 

## Versões

- **Ruby**: 3.3.0
- **Rails**: 7.1.4

## Dependências
- Docker 27.3.1
- Docker Compose
- Node.js
- PostgreSQL 16.4
- Redis

## Configuração

Antes de rodar a aplicação, é necessário configurar o ambiente Docker para garantir que todos os containers e dependências sejam corretamente inicializados.

### Passos para preparar o ambiente

1. **Certifique-se de ter o Docker e Docker Compose instalados em sua máquina.**

  Para verificar se o Docker está instalado corretamente, execute:

  ```
  docker --version
  docker-compose --version
  ```

  Se você não tiver o Docker instalado, siga as instruções de instalação do Docker para sua plataforma: https://docs.docker.com/get-docker/

2. Clonar o repositório: Se ainda não tiver o repositório, clone-o:

  ```
  git clone https://github.com/seu_usuario/inss-discount.git
  cd inss-discount
  ```

3. Rodar o comando para preparar o ambiente Docker: Execute a tarefa Rake para derrubar e recriar os containers:

  ```
  rails docker:prepare_server
  ```

  Esse comando fará o seguinte:

  - Derrubará todos os containers e volumes existentes
  - Limpará as imagens e containers não utilizados
  - Subirá os containers novamente com as configurações corretas

  Entre no ambiente Docker:

  ```
  docker exec -it inss-discount-web-1 bash
  ```

4. Criar o banco de dados: Após preparar o ambiente Docker, crie o banco de dados com o comando:

  ```
  rails db:create
  ```

## Rodando a aplicação

  Para rodar a aplicação no ambiente de desenvolvimento, basta entrar no ambiente Docker e executar:

  ```
  rails s
  ```

  Isso iniciará o servidor Rails e o Redis, tornando a aplicação acessível em http://localhost:3000.

## Rodando os testes

  Os testes são executados usando RSpec. Para rodar a suíte de testes, execute:

```
RAILS_ENV=test rspec
```

## Serviços

  Job queues (Sidekiq): Para rodar os jobs do Sidekiq, você pode iniciar o container do Sidekiq com o comando:

```
bundle exec sidekiq
```
