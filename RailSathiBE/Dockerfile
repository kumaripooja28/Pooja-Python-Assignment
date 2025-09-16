# syntax=docker/dockerfile:1

FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    POETRY_VIRTUALENVS_CREATE=false

WORKDIR /app

# System deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy project
COPY . /app

# Add wait script & entrypoint
COPY docker/entrypoint.sh /entrypoint.sh
COPY docker/wait-for.sh /wait-for.sh
RUN chmod +x /entrypoint.sh /wait-for.sh

EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]
