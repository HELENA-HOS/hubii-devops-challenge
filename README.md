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

## 📌 Próximas etapas
- Kubernetes
- CI/CD
- Terraform
- Segurança

## 🔧 Possíveis melhorias

- Utilizar multi-stage build para otimização da imagem
- Adicionar cache de dependências
- Implementar logs estruturados
- Adicionar autenticação no endpoint