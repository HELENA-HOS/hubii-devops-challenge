# 1. Imagem base oficial
FROM python:3.11-slim

# 2. Definir diretório de trabalho
WORKDIR /app

# 3. Copiar arquivos de dependência
COPY requirements.txt .

# 4. Instalar dependências
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copiar código da aplicação
COPY app ./app

# 6. Criar usuário não-root
RUN useradd -m appuser

# 7. Trocar para usuário não-root
USER appuser

# 8. Expor porta
EXPOSE 8080

# 9. Comando para rodar aplicação
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]