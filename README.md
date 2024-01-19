# Projeto de Ordenação e Relatório

Este projeto consiste em um programa COBOL com o objetivo de ordenar um arquivo com base em números de CNPJ e gerar um relatório correspondente.

## Detalhes do Programa

O programa foi escrito em COBOL e utiliza arquivos para entrada, saída e classificação. Abaixo estão alguns detalhes importantes sobre a estrutura do código:

### Arquivos de Entrada e Saída

- **Entrada (`Devedores.txt`):** Arquivo de dados que contém registros com informações, incluindo CNPJ, situação e valor.
- **Saída (`Relatorio.txt`):** Arquivo gerado pelo programa que apresenta um relatório ordenado com base no CNPJ.

### Arquivo de Classificação

- **Arquivo de Classificação (`Arqsort.txt`):** Arquivo temporário utilizado para classificar os registros com base no CNPJ.

### Estrutura do Código

O código está dividido em seções para inicialização, processamento e finalização:

- **Inicialização (`1000-INICIALIZAR`):** Abrir arquivos, inicializar cabeçalhos e classificar os dados.
- **Inicialização (`1100-INICIALIZAR-DATA-HORA`):** Abrir arquivos, inicializar cabeçalhos e classificar os dados.
- **Coleta de dados do sistema do usuário (`1100-INICIALIZAR-DATA-HORA`):**
- **Inicialização do cabeçalho do relatorio (`1200-INICIALIZAR-CABECALHO`):**
- **Processamento (`2000-PROCESSAR`):** Ler e processar os registros do arquivo de entrada.
- **Impressão e Ordenação (`2100-IMPRIMIR-SORT`):** Imprimir os registros ordenados no arquivo de saída.
- **Finalização (`3000-FINALIZAR`):** Fechar arquivos e encerrar o programa.

## Como Executar

1. Certifique-se de ter um compilador COBOL instalado.
2. Altere os caminhos dos arquivos de entrada, saída e classificação conforme necessário.
3. Compile e execute o programa usando o compilador COBOL.

## Notas Adicionaisada.

Esse projeto é uma implementação prática em COBOL para processar e relatar informações a partir de um arquivo de dados. Sinta-se à vontade para contribuir, relatar problemas ou sugerir melhorias.
