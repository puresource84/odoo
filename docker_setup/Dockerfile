# Use Python base image
FROM python:3.10-slim

# Set environment variables
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libldap2-dev \
    libsasl2-dev \
    libxml2-dev \
    libxslt1-dev \
    libjpeg-dev \
    libpq-dev \
    liblcms2-dev \
    libblas-dev \
    libatlas-base-dev \
    libssl-dev \
    libffi-dev \
    libtiff5-dev \
    libopenjp2-7-dev \
    zlib1g-dev \
    libwebp-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libxcb1-dev \
    xz-utils \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install pip requirements for Odoo + Babel manually
COPY ../requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip && \
    pip install -r /tmp/requirements.txt && \
    pip install Babel


# Install patched wkhtmltopdf binaries manually (Ubuntu-compatible build)
RUN apt-get update && apt-get install -y \
    xfonts-75dpi \
    xfonts-base \
    libxrender1 \
    libxext6 \
    libfontconfig1 \
    libfreetype6 \
    && curl -LO https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.bionic_amd64.deb \
    && apt-get install -y ./wkhtmltox_0.12.6-1.bionic_amd64.deb \
    && rm -rf ./wkhtmltox_0.12.6-1.bionic_amd64.deb


# Set working directory to official Odoo source (which is in root already)
WORKDIR /opt/odoo

# Copy all Odoo source files from the repo root
COPY .. .

# Default command
CMD ["python3", "odoo-bin", "--config", "/etc/odoo/odoo.conf"]
