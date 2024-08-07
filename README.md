# Otimização de Consultas em Sistemas Gerenciadores de Banco de Dados Relacionais

## [CEFET MG](https://www.cefetmg.br/)

### Banco de Dados 2

#### Autores:

[**Erick Henrique**](https://github.com/ErickHDdS) <br>
[**Iagor de Souza**](https://github.com/IagorSs) <br>
[**Marina Diniz**](https://github.com/pixel-debug) <br>

#### Download dos dados

Os dados podem ser obtidos através deste [link](https://dados.pbh.gov.br/dataset/contagens-volumetricas-de-radares). Eles representam as contagens volumétricas dos radares instalados nas principais vias de Belo Horizonte, classificadas por tipo de veículo.

#### Geração dos Arquivos `.sql`

Para gerar os arquivos `.sql` que serão usados na base de dados, siga os passos abaixo:

1. Copie a pasta contendo os dados de leituras dos radares de um dia específico para este diretório.
2. Altere o caminho do diretório no arquivo `jsonToSql.js` para o local onde a pasta de arquivos que deseja converter para `.sql` está localizada:

```javaScript
   const dir = "./20230806";
```

3. Execute o arquivo `jsonToSql.js`.

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
