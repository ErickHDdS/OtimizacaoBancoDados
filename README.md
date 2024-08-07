# Otimização de Consultas em Sistemas Gerenciadores de Banco de Dados Relacionais

## [CEFET MG](https://www.cefetmg.br/)

### Banco de Dados 2

#### Autores:

[**Erick Henrique**](https://github.com/ErickHDdS) <br>
[**Iagor de Souza**](https://github.com/IagorSs) <br>
[**Marina Diniz**](https://github.com/pixel-debug) <br>

#### Importação do Banco de Dados no PostgreSQL 16

Para importar as tabelas do banco de dados, siga os passos abaixo:

1. Faça o download do [PostgreSQL 16](https://www.postgresql.org/download/).
2. Após instalar o PostgreSQL 16, configure o arquivo `run.sh` com suas informações pessoais do banco de dados:
   ```sh
   DB_USER="seu_usuario"
   DB_NAME="nome_do_banco"
   DB_HOST="localhost"
   DB_PORT="5432"
   export PGPASSWORD="sua_senha"
   ```
3. Execute o comando `run.sh`
