# 🏢 Sistema de Gestão Corporativa (Funcionários e Agendas)

Aplicação web desenvolvida para a gestão completa de funcionários, agendas e marcação de compromissos corporativos. O sistema garante a integridade dos dados através de validações estritas de regras de negócio e gera relatórios dinâmicos.

> Projeto desenvolvido como resolução do Desafio Técnico do Programa de Formação Ager (SOC).

## 📦 Tecnologias Utilizadas

- **Back-end:** Java 8, Struts 2, SOAP Web Services.
- **Front-end:** HTML, JSP, Bootstrap 5.
- **Banco de Dados:** H2 Database (In-Memory) via JDBC.
- **Gerenciamento e Build:** Apache Maven, Jetty Server.
- **Bibliotecas Extras:** Apache POI (para geração de relatórios XLS/XLSX).

## 💼 Funcionalidades e Regras de Negócio

Este sistema vai além de um CRUD simples, implementando regras de negócio vitais para um ambiente corporativo:

- **Gestão de Funcionários e Agendas:** Cadastro completo com controle de "Períodos Disponíveis" (Manhã, Tarde, Ambos).
- **Agendamento Inteligente:** O sistema bloqueia a marcação de compromissos que estejam fora da disponibilidade da agenda do funcionário.
- **Integridade Relacional (Segurança de Dados):** - Exclusão em Cascata: Ao deletar um funcionário, seus compromissos atrelados são automaticamente removidos.
  - Bloqueio de Exclusão: É impossível deletar uma agenda que já possua compromissos cadastrados, evitando dados órfãos.
- **Motor de Relatórios:** Geração de relatórios de compromissos filtrados por período, com saída em tela (HTML) e exportação direta para planilhas do Excel (XLSX).

## 👩🏽‍💻 O Processo de Desenvolvimento

O projeto partiu de uma base pré-configurada, exigindo rápida adaptação à arquitetura existente. Comecei estruturando a camada de acesso a dados (DAO) e garantindo que os scripts SQL fossem executados corretamente no banco em memória H2 na inicialização do servidor.

O maior desafio prático foi orquestrar o fluxo MVC utilizando o framework **Struts 2**. Precisei mapear cuidadosamente as novas *Actions* no arquivo `struts.xml` e garantir que as mensagens do sistema fossem lidas corretamente dos arquivos `.properties` (i18n).

Na etapa de regras de negócio, foquei em criar validações no back-end para respeitar as restrições de horários e exclusão de chaves estrangeiras. Por fim, integrei a biblioteca **Apache POI** no fluxo da aplicação, manipulando o *response* HTTP para forçar o download do arquivo Excel gerado dinamicamente a partir dos dados do relatório.

## 📚 O Que Eu Aprendi

Lidar com este ecossistema me deu uma bagagem imensa sobre como sistemas corporativos legados e modernos operam.

☕ **Java Enterprise & Padrões de Projeto:**
- Aprofundei meu conhecimento no padrão MVC e em como frameworks consolidados como o Struts gerenciam o ciclo de vida das requisições e a injeção de dependências.

🗄️ **Bancos em Memória e JDBC:**
- Aprendi a configurar e interagir com o H2 Database, compreendendo o valor de bancos *in-memory* para testes rápidos e simulações de ambiente.

📊 **Manipulação de Arquivos e IO:**
- Dominar o Apache POI me mostrou como é o processo de traduzir objetos Java para linhas e colunas estruturadas dentro de arquivos binários como planilhas do Excel.

## 🚀 Como Executar

Pré-requisitos: Java 8 e Maven instalados.

1. Clone o repositório:
```bash
git clone [https://github.com/guiibqn/sistema-gestao-corporativa.git](https://github.com/guiibqn/sistema-gestao-corporativa.git)
```
2. Baixe as dependências via Maven:
```bash
mvn dependency:copy-dependencies
```
3. Inicie o servidor Jetty:
```bash
mvn jetty:run
```
4. Acesse no navegador: ```http://localhost:8080/avaliacao```

---
**Desenvolvido por:** Guilherme Augusto Boquimpani
