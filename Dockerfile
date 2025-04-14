# Použijte oficiální Python image jako základ
FROM python:3.10-slim

# Nastavení pracovního adresáře v kontejneru
WORKDIR /app

# Instalace systémových závislostí
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-venv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Vytvoření virtuálního prostředí
ENV VENV_PATH="/app/venv"
RUN python3 -m venv ${VENV_PATH}

# Aktivace virtuálního prostředí a instalace závislostí
ENV PATH="${VENV_PATH}/bin:$PATH"
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Kopírování aplikačního kódu do kontejneru
COPY . .

# Otevření portu, na kterém aplikace běží
EXPOSE 8000

# Příkaz pro spuštění aplikace
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
