# Stage 1: build wheels
FROM python:3.12-slim AS builder
WORKDIR /build

RUN apt-get update && apt-get install -y --no-install-recommends gcc \
  && rm -rf /var/lib/apt/lists/*

COPY app/requirements.txt .
RUN python -m pip install --upgrade pip \
  && pip wheel --no-cache-dir --wheel-dir /wheels -r requirements.txt

# Stage 2: runtime
FROM python:3.12-slim AS runtime
WORKDIR /app

RUN useradd -m appuser
USER appuser

COPY --from=builder /wheels /wheels
COPY app/requirements.txt .

RUN python -m pip install --no-cache-dir --find-links=/wheels -r requirements.txt

COPY app/ .
EXPOSE 8080
CMD ["python", "main.py"]

