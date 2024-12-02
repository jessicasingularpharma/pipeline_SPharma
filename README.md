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


# Proximos Passos

- Escalabilidade: Melhorar a escalabilidade para lidar com maiores volumes de dados.

- Monitoramento: Implementar ferramentas de monitoramento para garantir a integridade contínua dos dados.

- Construção do Dashboard no Power BI com foco em Compras.

  # Propostas de Novos design do Dashboard:

  Modelo 1 :
[modelo1]


  Modelo 2:

  [modelo 2]

# Conclusão:

Este projeto de pipeline de dados oferece uma solução robusta para a integração, transformação e visualização de dados na Singular Pharma, trazendo benefícios significativos em termos de eficiência e qualidade dos dados.
