# 📦 Imagem base oficial Python 3.11 Slim (leve e segura)
FROM python:3.11-slim

# 🛠️ Variáveis de ambiente: evita arquivos .pyc e ativa logs imediatos
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    POETRY_VIRTUALENVS_CREATE=false \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# 🗂️ Define o diretório de trabalho
WORKDIR /app

# 🔒 Cria um usuário não-root para rodar a aplicação com mais segurança
RUN addgroup --system appuser && \
    adduser --system --ingroup appuser --disabled-password appuser

# 🧱 Instala dependências essenciais do sistema e remove cache
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        gcc \
        curl \
        libpq-dev \
        libffi-dev \
        libssl-dev \
        netcat \
        ca-certificates \
    && apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 📄 Copia apenas o arquivo de dependências para melhor cache
COPY requirements.txt .

# 🔄 Atualiza o pip e instala dependências do Python
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# 📦 Copia o restante do código da aplicação
COPY . .

# 🔐 Ajusta permissões da pasta da aplicação
RUN chown -R appuser:appuser /app

# 👤 Troca para o usuário de execução seguro
USER appuser

# 📢 Expõe a porta padrão da aplicação (Flask/Gunicorn)
EXPOSE 5000

# 🚀 Comando de inicialização com Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers=4", "--threads=2", "--timeout=120", "app:app"]
