#install python en pip
ARG BUILD_FROM
ARG BUILD_VERSION
ARG BUILD_ARCH
ARG BUILD_NAME
ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETVARIANT
ARG TARGETOS

#FROM $BUILD_FROM
FROM ghcr.io/hassio-addons/ubuntu-base:10.0.5
# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

<<<<<<< HEAD
<<<<<<< HEAD
RUN apt-get update && apt-get upgrade -y
RUN apt-get dist-upgrade -y
#RUN apt-get install -y python3
RUN apt-get update && apt-get install -y --no-install-recommends python3-minimal 
# Added libffi-dev to resolve cffi dependancy errors
RUN apt-get install -y python3-pip libffi-dev
=======
=======
>>>>>>> upstream/main
# Install Python and pip in a single layer
# Using python3 instead of python3-minimal for better pip package compatibility
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        python3 \
        python3-pip \
    && rm -rf /var/lib/apt/lists/*
<<<<<<< HEAD
>>>>>>> upstream/main
=======
>>>>>>> upstream/main

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
ARG BUILD_FROM
ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETVARIANT
ARG TARGETOS
# Build simple HA-compatible architecture string
# Home Assistant expects:
#   amd64
#   armv7
#   armhf
#   aarch64
#
# TARGETARCH / TARGETVARIANT → convert manually
RUN if [ "$TARGETARCH" = "arm" ] && [ "$TARGETVARIANT" = "v7" ]; then \
        echo "armv7" > /archname; \
    elif [ "$TARGETARCH" = "arm" ]; then \
        echo "armhf" > /archname; \
    elif [ "$TARGETARCH" = "amd64" ]; then \
        echo "amd64" > /archname; \
    elif [ "$TARGETARCH" = "arm64" ]; then \
        echo "aarch64" > /archname; \
    else \
        echo "$TARGETARCH" > /archname; \
    fi


LABEL \
    io.hass.name="predbat_addon" \
#        io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${TARGETARCH}${TARGETVARIANT:+-$TARGETVARIANT}" \
    #io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=1.3.2 \
    #io.hass.version=${BUILD_VERSION} \
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
