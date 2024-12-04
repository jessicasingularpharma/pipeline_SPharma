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


  # Design do Dashboard de Compras:

  #### O dashboard será composto por quatro páginas principais, otimizadas para análise estratégica e operacional:



 1- **Visão Geral**
  
 -  Informações consolidadas:
 - Compras por tipo (Matéria-prima, Embalagem, Revenda e Outros).
 - Distribuição por fornecedor (% de compras).
 - Valores totais de compras por mês.


  2-  **Financeiro**
  
    - Indicadores-chave (KPIs):
      
      - Valores gastos por ano, mês e dia.
     - Valor médio de compras por produto.
     - Quantidade comprada em diferentes unidades (kg, g, etc.).
 

  3- **Análise de Produtos**
    
 -  KPIs detalhados:
   - Quantidade comprada por período.
   - Informações por produto:
   - Valor unitário e total.
   - Número da nota fiscal.
   - Grupo e curva de consumo.
   - Data de entrada no estoque.
   -  Custo das Mercadorias Vendidas (CMV), categorizado.
   
 
   4-  **Fornecedores**
 
- Análise por fornecedor:
- Produtos fornecidos por CNPJ.
- Lead Time médio (tempo entre pedido e entrega).
- Quantidade de compras por fornecedor.
  
 
 #### Paginas do Dashboard que estão em Andamento:

  Pagina de Exemplo :
  
  ![modelo1](https://github.com/jessicasingularpharma/pipeline_SPharma/blob/main/dashboard-modelo.PNG)


  Pagina Exemplo 2:

  ![modelo 2](https://github.com/jessicasingularpharma/pipeline_SPharma/blob/main/modelo%20dashboard.PNG)

# Conclusão:

O pipeline de dados implementado para a Singular Pharma proporciona uma solução robusta e escalável para integração, processamento e visualização de dados. Com isso, a organização pode realizar análises precisas e rápidas, suportando decisões baseadas em dados confiáveis, seja em análises históricas ou operacionais diárias.

**Próximo impacto esperado: otimização contínua para atender às demandas crescentes de dados e análise.**
