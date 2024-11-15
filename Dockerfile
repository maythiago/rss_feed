# Dockerfile

# Use a imagem oficial do Ruby 3.3.5 como base
FROM ruby:3.3.5

# Instale dependências
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    graphviz \
    yarn

# Defina o diretório de trabalho dentro do container
WORKDIR /app

# Copie o Gemfile e o Gemfile.lock para o container
COPY Gemfile Gemfile.lock ./

# Instale as gems
RUN gem install bundler && bundle install

# Copie o restante do código da aplicação para o container
COPY . .

# Porta que o servidor Rails utilizará
EXPOSE 3000

# Comando de inicialização do servidor Rails
CMD ["rails", "server", "-b", "0.0.0.0"]
