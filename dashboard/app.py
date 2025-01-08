import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt

# Título do Dashboard
st.title("Dashboard de Compras")

# Carregar o arquivo CSV
uploaded_file = st.file_uploader("C:\Users\Oem\pipeline_etl_firebird\dashboard\data\sm empreendimentos.csv", type="csv")

if uploaded_file is not None:
    # Ler o arquivo CSV
    df = pd.read_csv(uploaded_file)
    
    # Converter a coluna de data para o tipo datetime
    df['DTENT'] = pd.to_datetime(df['DTENT'])
    
    # Filtros interativos
    st.sidebar.header("Filtros")
    start_date = st.sidebar.date_input("Data inicial", df['DTENT'].min())
    end_date = st.sidebar.date_input("Data final", df['DTENT'].max())
    
    if start_date > end_date:
        st.sidebar.error("Erro: A data final deve ser posterior à data inicial.")
    
    # Filtrar os dados com base nas datas selecionadas
    filtered_df = df[(df['DTENT'] >= start_date) & (df['DTENT'] <= end_date)]
    
    # Calcular o valor total de compras por mês
    filtered_df['AnoMes'] = filtered_df['DTENT'].dt.to_period('M')
    compras_por_mes = filtered_df.groupby('AnoMes')['PRCOMN'].sum().reset_index()
    compras_por_mes.columns = ['AnoMes', 'ValorTotalCompras']
    
    # Calcular o valor total de compras por ano
    filtered_df['Ano'] = filtered_df['DTENT'].dt.year
    compras_por_ano = filtered_df.groupby('Ano')['PRCOMN'].sum().reset_index()
    compras_por_ano.columns = ['Ano', 'ValorTotalCompras']
    
    # Tipo de gráfico
    chart_type = st.sidebar.selectbox("Selecione o tipo de gráfico", ["Linha", "Barra"])
    
    # Plotar o gráfico de compras por mês
    st.subheader("Valor Total de Compras por Mês")
    fig, ax = plt.subplots()
    if chart_type == "Linha":
        ax.plot(compras_por_mes['AnoMes'].astype(str), compras_por_mes['ValorTotalCompras'], marker='o', linestyle='-')
    else:
        ax.bar(compras_por_mes['AnoMes'].astype(str), compras_por_mes['ValorTotalCompras'], color='skyblue')
    ax.set_title('Valor Total de Compras por Mês')
    ax.set_xlabel('Mês')
    ax.set_ylabel('Valor Total de Compras')
    ax.tick_params(axis='x', rotation=45)
    ax.grid(True)
    st.pyplot(fig)
    
    # Plotar o gráfico de compras por ano
    st.subheader("Valor Total de Compras por Ano")
    fig, ax = plt.subplots()
    if chart_type == "Linha":
        ax.plot(compras_por_ano['Ano'], compras_por_ano['ValorTotalCompras'], marker='o', linestyle='-')
    else:
        ax.bar(compras_por_ano['Ano'], compras_por_ano['ValorTotalCompras'], color='skyblue')
    ax.set_title('Valor Total de Compras por Ano')
    ax.set_xlabel('Ano')
    ax.set_ylabel('Valor Total de Compras')
    ax.grid(axis='y')
    st.pyplot(fig)
