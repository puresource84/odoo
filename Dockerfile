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




# Set working directory to official Odoo source (which is in root already)
WORKDIR /opt/odoo

# Copy all Odoo source files from the repo root
COPY .. .

# Default command
CMD ["python3", "odoo-bin", "--config", "/etc/odoo/odoo.conf"]
