# Hubii DevOps Challenge

## 📌 Sobre o projeto

Este projeto foi desenvolvido como parte de um desafio técnico para a vaga de Jr DevOps Analyst.

O objetivo é demonstrar conhecimentos básicos em:

- Desenvolvimento de aplicações
- Containerização com Docker
- Orquestração com Kubernetes
- CI/CD
- Infraestrutura como código
- Boas práticas de segurança

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

## ☸️ Parte 3 — Kubernetes

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

## 📌 Próximas etapas

- CI/CD
- Terraform
- Segurança

