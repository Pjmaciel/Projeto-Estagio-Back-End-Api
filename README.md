# Back-End API Project

![Ruby on Rails](https://img.shields.io/badge/Ruby%20on%20Rails-5.2.3-red)
![RSpec](https://img.shields.io/badge/RSpec-3.8-green)
![JWT](https://img.shields.io/badge/JWT-Auth-blue)
![License](https://img.shields.io/badge/license-MIT-brightgreen)

## Sobre o Projeto

Este projeto é uma API Back-End construída usando Ruby on Rails. Ele simula o fluxo de um sistema de coleta de dados em campo, incluindo funcionalidades para gerenciamento de usuários, visitas, formulários, perguntas e respostas.

## Tecnologias Utilizadas

- ![Ruby on Rails](https://img.shields.io/badge/Ruby%20on%20Rails-API%20Only-red)
- ![RSpec](https://img.shields.io/badge/RSpec-Test-blue)
- ![JWT](https://img.shields.io/badge/JWT-Authentication-brightgreen)

## Objetivo

Organizar e estruturar dados coletados em campo, permitindo a saída em JSON para servidores externos, como um front-end requisitando informações de coletas.

## Funcionalidades

- **Usuário**: Identifica e autentica a pessoa no sistema.
- **Visita**: Tarefa com data agendada e informações de checkin e checkout.
- **Formulários**: Questionários com várias perguntas específicas.
- **Perguntas**: Perguntas de um formulário.
- **Respostas**: Respostas das perguntas.

## Instalação e Configuração

### Pré-requisitos

- Ruby 3.3+
- Rails 6.0+
- PostgreSQL

### Passo a Passo

1. Clone o repositório:
   ```sh
   git clone <URL-do-repositório>
   cd <nome-do-repositório>
   ```

2. Instale as dependências:
   ```sh
   bundle install
   ```

3. Configure o banco de dados:
   ```sh
   rails db:create db:migrate
   ```

4. Inicie o servidor:
   ```sh
   rails server
   ```

## Estrutura do Projeto

### Entidades Principais

#### USER

- **Campos**:
  - Nome
  - Senha
  - E-mail
  - CPF

- **Validações**:
  - Senha deve ter mais de seis dígitos, variando entre números e letras.
  - E-mail deve ser único.
  - CPF deve ser único e válido.

#### VISIT

- **Campos**:
  - Data
  - Status (PENDENTE, REALIZANDO, REALIZADA)
  - user_id
  - checkin_at (Datetime)
  - checkout_at (Datetime)

- **Validações**:
  - Data deve ser maior ou igual à data atual.
  - checkin_at não pode ser maior ou igual ao dia atual, e menor que a data de checkout.
  - checkout_at deve ser maior que checkin_at.
  - user_id deve ser um usuário válido.

#### FORMULARY

- **Campos**:
  - Nome

- **Validações**:
  - Nome deve ser único.

#### QUESTION

- **Campos**:
  - Nome
  - formulary_id
  - Tipo de pergunta (Texto, Foto)

- **Validações**:
  - Nome deve ser único dentro do formulário.

#### ANSWER

- **Campos**:
  - content
  - formulary_id
  - question_id
  - visit_id
  - answered_at

- **Validações**:
  - question_id deve existir.
  - formulary_id deve existir.

## Testes

Para executar os testes, use o comando:
```sh
rspec
```

Para Testar o funcionamento da API com o Postman:
```sh
https://documenter.getpostman.com/view/28918911/2sA3rzLYpD
```

## Autenticação JWT

A API utiliza JWT para autenticação de usuário. O token é validado para verificar se o usuário está logado e tem permissões de acesso.


