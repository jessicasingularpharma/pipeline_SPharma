![Processo Atual](https://github.com/jessicasingularpharma/pipeline_SPharma/blob/main/pipeline-singular%20pharma)
 
 
 
 # Pipeline de dados Singular Pharma

 Este documento apresenta o projeto de pipeline de dados desenvolvido para a Singular Pharma, cujo objetivo é integrar dados da fonte, realizar transformações, e carregar dados processados em um data warehouse.

# Objetivo

O objetivo principal deste pipeline é melhorar a eficiência do processamento de dados, garantir a integridade dos dados e possibilitar seu consumo a partir de uma ferramenta de visualização de dados (Power BI).


# Arquitetura

O pipeline de dados é composto pelas seguintes etapas:

- **Fontes de Dados**: Formúla Certa (ERP)

- **Processamento de Dados**:

 **Extração**: Os dados brutos são extraídos do Banco de Produção do Formúla Certa. 

**Staging** : Os dados extraídos são carregados continuamente na camada de Staging.

**Transformação**: Nesta etapa, os dados passam por processos de limpeza, remoção de valores nulos e incorretos, e agregações para enriquecimento dos dados.

**Silver Layer**: Os dados tratados são armazenados na camada Silver, uma camada intermediária.

**Gold Layer**: Os dados transformados e enriquecidos são carregados na camada Gold do Data Warehouse, prontos para consumo pelo Power BI.

- **Armazenamento de Dados**: Todo o armazenamento é feito em um banco de dados PostgreSQL.


# Tecnologias Utilizadas:

- Linguagem de Programação: Python
- Ferramentas ETL: python e Apache Airflow
- Banco de Dados: Postgres
- Ferramenta de Visualização: Power BI


# Implementação

Estrutura do Código: O projeto está organizado de forma modular, com scripts separados para extração, transformação e carregamento (ETL).

Configuração: O ambiente de desenvolvimento e execução é configurado através de arquivos de configuração e scripts de inicialização.

Execução: O pipeline pode ser executado automaticamente usando o Apache Airflow para agendamento e monitoramento das tarefas.


# Resultados:

O pipeline de dados melhora significativamente a eficiência do processamento de dados, garante a integridade dos dados e facilita a análise e visualização de dados no Power BI.


# Proximos Passos(Em Andamento)

- Escalabilidade: Melhorar a escalabilidade para lidar com maiores volumes de dados.

- Monitoramento: Implementar ferramentas de monitoramento para garantir a integridade contínua dos dados.

- Construção do Dashboard no Power BI com foco em Compras.


  # Propostas de Novos design do Dashboard:

  O layout do novo Dashboard de compras, conta com 4 paginas para Analise:

  - Primeira pagina, de Visão Geral, que possui `informações gerais de compras por Materia Prima, Embalagem, Porcentagem de compras por Fornecedor e valor total de compras por mês`.
   
   - A Segunda pagina é a de Financeiro que tera Os KPIS de Valores, como `Quantidade gasta por ano, mes(ou dia) de materia prima, considerando KG, G, CAP a depender do produto.`  `Valor Médio de Compras por Produto` 
      
   - A Terceira Pagina será referente a Analises de cada produto, contendo KPIS que quantificam, ´Quantidade Comprada por Período`, Todos os produtos comprados contendo `Valor unitario`, `Numero de Nota fiscal`, `Valor total de Compra do produto`, `Grupo`, `Curva` e `data de entrada do produto` e O cmv Em Categorias.
 
   - A Quarta e Ultima Pagina sera referente  A fornecedores, Contendo produtos de Cada Fornecedores, permitindo analise individual de produto por cada CNPJ. O Lead Time Médio de Compra para analisar o tempo medio entre as datas de entregas dos produtos e a quantidade de compras por Fornecedor.
 
 #### Paginas do Dashboard que estão em Andamento:

  Pagina de Exemplo :
  ![modelo1](https://github.com/jessicasingularpharma/pipeline_SPharma/blob/main/dashboard-modelo.PNG)


  Pagina Exemplo 2:

  ![modelo 2](https://github.com/jessicasingularpharma/pipeline_SPharma/blob/main/modelo%20dashboard.PNG)

# Conclusão:

Este projeto de pipeline de dados oferece uma solução robusta para a integração, transformação e visualização de dados na Singular Pharma, trazendo benefícios significativos em termos de eficiência e qualidade dos dados, permitindo ter uma analise Historia e e Diária.
