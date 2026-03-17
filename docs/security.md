# 🔐 Segurança no Projeto

Este documento descreve as práticas de segurança consideradas para a aplicação, infraestrutura e pipeline CI/CD.

---

## 🔑 Gestão de segredos em produção

Em ambientes produtivos, segredos como senhas, tokens e chaves de acesso não devem ser armazenados no código.

Boas práticas:

- Utilizar variáveis de ambiente para injeção de segredos
- Utilizar ferramentas específicas como:
  - AWS Secrets Manager
  - HashiCorp Vault
  - Kubernetes Secrets
- Integrar segredos ao pipeline CI/CD de forma segura

---

## 🚫 Evitar exposição de credenciais

Para evitar vazamento de informações sensíveis:

- Não versionar arquivos `.env`
- Utilizar `.gitignore` para proteger dados sensíveis
- Evitar hardcoding de credenciais no código ou Terraform
- Utilizar variáveis em vez de valores fixos

---

## 🐳 Segurança da imagem Docker

Boas práticas aplicadas no projeto:

- Uso de imagem base oficial (`python:3.11-slim`)
- Execução com usuário não-root
- Redução da superfície de ataque

Melhorias possíveis:

- Atualização frequente da imagem base
- Uso de imagens minimalistas (distroless ou alpine)
- Scan contínuo de vulnerabilidades com Trivy
- Remoção de dependências desnecessárias

---

## ☁️ Boas práticas de acesso em ambientes cloud

Para garantir segurança em ambientes cloud:

- Aplicar o princípio do menor privilégio (IAM)
- Restringir acessos apenas ao necessário
- Utilizar roles em vez de credenciais fixas
- Rotacionar credenciais periodicamente
- Monitorar acessos e atividades

---

## 🔄 Segurança no pipeline CI/CD

- Uso de scan de vulnerabilidades com Trivy
- Política de falha baseada em severidade (CRITICAL)
- Separação entre visibilidade e bloqueio de vulnerabilidades

---

## 🧠 Considerações finais

A segurança foi tratada como parte do ciclo de desenvolvimento (DevSecOps), garantindo que boas práticas sejam aplicadas desde o desenvolvimento até a entrega da aplicação.

---