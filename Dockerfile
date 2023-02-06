FROM debian:11.6-slim as ledfx-build

ARG LEDFX_VERSION="2.0.60"

# Install dependencies
RUN set -eux && apt-get update && apt-get install -y \
  gcc \
  git \
  libatlas3-base \
  libavformat58 \
  libavcodec-dev \
  portaudio19-dev \
  pulseaudio \
  python3 \
  python3-pip \
  python3-venv \
  && python3 -m venv /opt/venv \
  && . /opt/venv/bin/activate \ 
  # aubio errors on the first pip command, however if we don't install it here, it will fail later
  && python3 -m pip install --upgrade pip wheel setuptools aubio  \
  && python3 -m pip install ledfx==${LEDFX_VERSION}

FROM debian:11.6-slim as ledfx
ARG EXTRA_APT_PKGS=""
ENV PATH="/opt/venv/bin:$PATH"

RUN set -eux && apt-get update && apt-get install -y --no-install-recommends \
  alsa-utils \
  gosu \
  libatlas3-base \
  libavformat58 \
  libavcodec58 \
  libportaudio2 \
  pulseaudio \
  python3 \
  python3-distutils \
  avahi-daemon ${EXTRA_APT_PKGS}

COPY --from=ledfx-build --chown=1000:1000 /opt/venv /opt/venv
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh \
  && useradd -u 1000 -U -d /home/ledfx -s /bin/false ledfx \
  && mkdir -p /home/ledfx \
  && chown -R ledfx:ledfx /home/ledfx \
  && usermod -G audio ledfx

# Expose the port
EXPOSE 8888
ENTRYPOINT ["/app/start.sh"]