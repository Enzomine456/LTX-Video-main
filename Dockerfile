# Base oficial do Python 3.11 slim (mais leve)
FROM python:3.11-slim

# Variáveis de ambiente (melhora logs e evita arquivos .pyc)
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    POETRY_VIRTUALENVS_CREATE=false

# Diretório de trabalho no container
WORKDIR /app

# Instalações de dependências do sistema e limpeza para reduzir imagem
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
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copia apenas requirements.txt inicialmente para melhor cache
COPY requirements.txt .

# Atualiza pip e instala as dependências
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Copia o restante da aplicação
COPY . .

# Ajusta permissões (boa prática para segurança)
RUN adduser --disabled-password appuser && \
    chown -R appuser /app
USER appuser

# Expõe a porta do Flask/Gunicorn
EXPOSE 5000

# Comando padrão: Gunicorn com auto reload em dev ou pronto para prod
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers=4", "--threads=2", "--timeout=120", "app:app"]
