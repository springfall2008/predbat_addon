#install python en pip
ARG BUILD_FROM
ARG BUILD_VERSION
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install Python and pip in a single layer
# Using python3 instead of python3-minimal for better pip package compatibility
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        python3 \
        python3-pip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app_data
COPY rootfs /
# COPY ingress.conf /etc/nginx/http.d/

COPY requirements.txt /tmp/
RUN pip install --break-system-packages -r /tmp/requirements.txt

# Start app
RUN chmod a+x /run.sh

ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="springfall2008 (https://github.com/springfall2008)" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Springfall2008" \
    org.opencontainers.image.authors="springfall2008 (https://github.com/springfall2008)" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/springfall2008" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}

#CMD [ "/run.sh" ]
