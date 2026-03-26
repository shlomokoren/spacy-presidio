FROM python:3.11-slim

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

# Install build deps TEMPORARILY + install Python deps in same layer
RUN apt-get update && apt-get install -y --no-install-recommends \
        gcc \
        build-essential \
        curl \
    && pip install --upgrade pip \
    && pip install \
        spacy==3.8.13 \
        python-dotenv \
        ldap3 \
        presidio-analyzer \
        requests \
    && python -m spacy download en_core_web_lg \
    \
    # 🔥 remove build tools after install
    && apt-get purge -y gcc build-essential \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /root/.cache/pip

CMD ["python"]