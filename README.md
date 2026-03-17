# Hubii DevOps Challenge

## 📌 Sobre o projeto

Projeto desenvolvido para demonstrar conhecimentos práticos em:

- APIs e aplicações backend
- Containerização com Docker
- Orquestração com Kubernetes
- CI/CD com GitHub Actions
- Infraestrutura como Código (Terraform)
- Segurança (DevSecOps)

---
## 📚 Índice

- [🚀 Parte 1 — Aplicação](#-parte-1--aplicação)
- [🐳 Parte 2 — Containerização com Docker](#-parte-2--containerização-com-docker)
- [☸️ Parte 3 — Kubernetes](#-parte-3--kubernetes)
- [🔄 Parte 4 — Pipeline CI/CD](#-parte-4--pipeline-cicd)
- [🌍 Parte 5 — Terraform](#-parte-5--terraform-infraestrutura-como-código)
- [🔐 Parte 6 — Seguranca](#-parte-6--seguranca)

---

## 🚀 Parte 1 — Aplicação

Foi desenvolvida uma aplicação simples utilizando **FastAPI**, expondo um endpoint de health check.

### Endpoint
```
GET /health
```

### Resposta esperada

```json
{
  "status": "ok",
  "version": "1.0.0",
  "environment": "APP_ENV"
}
```

### Características

- Executa na porta `8080`
- Utiliza variável de ambiente `APP_ENV`
- Estruturada para simular um microserviço

---

## 🐳 Parte 2 — Containerização com Docker

A aplicação foi containerizada utilizando Docker.

### Principais decisões

- Utilização de imagem base oficial `python:3.11-slim`
- Uso de usuário não-root para maior segurança
- Separação de dependências via `requirements.txt`
- Aplicação exposta na porta `8080`

### Build da imagem

```bash
docker build -t hubii-devops-app .
```

### Execução do container
```bash
docker run -p 8080:8080 -e APP_ENV=local hubii-devops-app
```

### Teste

Acessar:
```
http://localhost:8080/health
```

## 🔧 Possíveis melhorias

- Utilizar multi-stage build para otimização da imagem
- Adicionar cache de dependências
- Implementar logs estruturados
- Adicionar autenticação no endpoint

---

## ☸ Parte 3 — Kubernetes

Foram criados manifestos Kubernetes para executar a aplicação em um cluster.

### Estrutura

- Deployment
- Service
- Ingress

### Deployment

Responsável por gerenciar os pods da aplicação.

Principais configurações:

- Definição de `replicas`
- Variável de ambiente `APP_ENV`
- Requests e limits de CPU e memória
- Configuração de `readinessProbe` e `livenessProbe` utilizando o endpoint `/health`

### Service

Responsável por expor a aplicação internamente no cluster.

- Tipo: `ClusterIP`
- Porta 80 direcionando para a porta 8080 do container

### Ingress

Responsável por expor a aplicação externamente.

- Configuração de rota para o serviço `hubii-service`

---

### 🔐 Boas práticas de segurança

Neste projeto não foram utilizados segredos sensíveis diretamente nos manifestos.

Em cenários reais, informações como senhas e tokens devem ser gerenciadas utilizando:

- Kubernetes Secrets
- Ferramentas de gestão de segredos (ex: AWS Secrets Manager, Vault)

---

### 📌 Observações

Os manifestos foram estruturados seguindo boas práticas de organização, separando aplicação e infraestrutura e utilizando configurações básicas de observabilidade e controle de recursos.

---

## 🔁 Parte 4 — Pipeline CI/CD

Foi implementado um pipeline de Integração Contínua utilizando GitHub Actions, com o objetivo de automatizar validações básicas da aplicação, infraestrutura e análise de segurança da imagem Docker.

### ⚙️ Etapas do pipeline

O pipeline é executado a cada push na branch principal (`main`) e contempla as seguintes etapas:

1. **Checkout do código**
2. **Configuração do ambiente Python (lint básico)**
3. **Instalação de dependências**
4. **Validação de sintaxe da aplicação Python**
5. **Validação de infraestrutura com Terraform**
6. **Build da imagem Docker**
7. **Scan de vulnerabilidades com Trivy**

---

### 🧠 Validação de Terraform

Foi adicionada uma etapa de validação da infraestrutura como código utilizando Terraform, contendo:

- `terraform init -backend=false`
- `terraform fmt -check`
- `terraform validate`

Essa etapa garante:

- Correção da sintaxe dos arquivos `.tf`
- Padronização de formatação
- Integridade da configuração antes do uso

---

### 🔍 Scan de vulnerabilidades

A análise de vulnerabilidades foi implementada utilizando a ferramenta **Trivy**, com uma abordagem em duas etapas:

#### 1. Scan completo (visibilidade)

Executa uma análise completa da imagem Docker, considerando vulnerabilidades de todos os níveis:

- LOW
- MEDIUM
- HIGH
- CRITICAL

Essa etapa **não bloqueia o pipeline**, permitindo visibilidade total dos riscos identificados.

#### 2. Scan com política de falha (fail policy)

Executa uma nova análise considerando apenas vulnerabilidades do tipo:

- CRITICAL

O pipeline é configurado para **falhar caso sejam encontradas vulnerabilidades críticas**, garantindo controle sobre riscos mais severos.

---

### 🧠 Decisão técnica

A separação entre visibilidade e controle foi adotada para equilibrar segurança e viabilidade do fluxo de entrega.

Vulnerabilidades de níveis mais baixos (LOW, MEDIUM e HIGH) podem estar relacionadas a dependências da imagem base e nem sempre estão sob controle direto da aplicação. Por isso, são reportadas, mas não bloqueiam o pipeline.

Já vulnerabilidades CRITICAL representam riscos mais severos e, portanto, são tratadas como critério de falha.

Essa abordagem foi adotada para equilibrar visibilidade e controle, permitindo acompanhamento contínuo de vulnerabilidades sem comprometer o fluxo de entrega por problemas fora do controle direto da aplicação.

---

### 🔄 Observação sobre execução dos steps

Durante a execução do pipeline, podem aparecer etapas com prefixo `Post` (ex: `Post Scan completo`).

Essas etapas são geradas automaticamente pelas actions utilizadas e representam processos de finalização (cleanup), como liberação de recursos e limpeza de ambiente.

Esses steps são executados em ordem reversa (LIFO — Last In, First Out), o que pode causar uma diferença visual na sequência exibida no GitHub Actions, sem impactar a lógica do pipeline.

---

### 🔧 Possíveis melhorias

Em um cenário de produção, poderiam ser implementadas melhorias como:

#### 🔐 Segurança (DevSecOps)

- Definição de políticas de severidade mais refinadas
- Atualização automatizada de imagens base
- Integração com ferramentas de gestão de vulnerabilidades
- Geração de relatórios estruturados (JSON ou SARIF)
- Integração com ferramentas de segurança contínua (DevSecOps)

#### ⚙️ Pipeline e engenharia

- Cache de dependências Python
- Build e push de imagem para registry (Docker Hub / ECR)
- Testes automatizados da aplicação
- Uso de ambientes (dev/staging/prod)
- Integração com ferramentas de observabilidade
- Scan de dependências (SCA)

---


## 🌍 Parte 5 — Terraform (Infraestrutura como Código)

Foi implementado um exemplo simples de infraestrutura utilizando Terraform, com o objetivo de demonstrar conceitos fundamentais de Infraestrutura como Código (IaC), organização de variáveis e validação em pipeline CI/CD.

---

### 📁 Estrutura

Os arquivos foram organizados na pasta `terraform/`:

- `main.tf` → definição dos recursos
- `variables.tf` → declaração das variáveis
- `terraform.tfvars` → valores das variáveis
- `outputs.tf` → saída de informações relevantes

---

### ⚙️ Recurso provisionado

Foi definido um recurso simples:

- **Bucket S3 (AWS)**

Este recurso foi escolhido por ser amplamente utilizado e suficiente para demonstrar conceitos básicos de provisionamento em cloud.

---

### 🧠 Uso de variáveis

As variáveis foram utilizadas para tornar o código reutilizável e flexível.

Exemplos:

- `bucket_name`
- `aws_region`
- `environment`

Os valores são definidos no arquivo `terraform.tfvars`, garantindo separação entre configuração e código.

---

### 🔄 Fluxo de utilização

O fluxo do Terraform neste projeto segue:

1. Declaração de variáveis (`variables.tf`)
2. Atribuição de valores (`terraform.tfvars`)
3. Uso das variáveis nos recursos (`main.tf`)
4. Exposição de outputs (`outputs.tf`)

---

### 📤 Outputs

Foi definido um output para exibir o nome do bucket criado:

- `bucket_name`

Outputs permitem visualizar informações importantes após execução e facilitam integrações futuras.

---

### 🔍 Validação no pipeline CI/CD

A infraestrutura é validada automaticamente na pipeline, garantindo qualidade antes de qualquer uso.

Etapas aplicadas:

- `terraform init -backend=false`
- `terraform fmt -check`
- `terraform validate`

Essa validação garante:

- Sintaxe correta
- Código padronizado
- Configuração consistente

---

### 🚫 Execução não obrigatória

Não foi realizado `terraform apply`, pois o objetivo do desafio é validar conhecimento estrutural e organização do código, não sendo necessário provisionar recursos reais.

---

### 🧠 Decisões técnicas

- Uso de variáveis para evitar hardcoding
- Separação entre código e configuração
- Estrutura modular e organizada
- Integração com pipeline CI/CD
- Validação automatizada da infraestrutura

---

### 🔧 Possíveis melhorias

Em um cenário real:

- Backend remoto para state (S3 + DynamoDB)
- Uso de módulos reutilizáveis
- Workspaces para múltiplos ambientes
- Integração com CI/CD para apply controlado
- Políticas de segurança (IAM com menor privilégio)
- Validação avançada de variáveis

---

## 🔐 Parte 6 — Seguranca

As práticas de segurança adotadas no projeto podem ser consultadas no documento abaixo:

[Documentação de Segurança](docs/security.md)

---
## 👩🏽‍💻 Autora

Helena Oliveira Silva  
DevOps | SRE | Automação



