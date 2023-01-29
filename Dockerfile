FROM debian:11.6-slim

ARG EXTRA_APT_PKGS=""
ARG EXTRA_PIP_PKGS=""
ARG LEDFX_VERSION="2.0.60"

# Install dependencies
RUN set -eux && apt-get update && apt-get install -y \
  gosu \
  gcc \
  git \
  libatlas3-base \
  libavformat58 \
  libavcodec-dev \
  portaudio19-dev \
  pulseaudio \
  python3-pip \
  avahi-daemon ${EXTRA_APT_PKGS} \
  && rm -rf /var/lib/apt/lists/*

# aubio errors on the first pip command, however if we don't install it here, it will fail later
RUN python3 -m pip install --no-cache-dir --upgrade pip wheel setuptools aubio ${EXTRA_PIP_PKGS} && \
  python3 -m pip install --no-cache-dir ledfx==${LEDFX_VERSION}

ADD start.sh /app/start.sh
RUN chmod +x /app/start.sh \
  && useradd -u 1000 -U -d /home/ledfx -s /bin/false ledfx \
  && mkdir -p /home/ledfx \
  && chown -R ledfx:ledfx /home/ledfx \
  && usermod -G audio ledfx

# Expose the port
EXPOSE 8888
ENTRYPOINT ["/app/start.sh"]