FROM debian:11.6-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
  gcc \
  git \
  libatlas3-base \
  libavformat58 \
  libavcodec-dev \
  portaudio19-dev \
  pulseaudio \
  python3-pip \
  avahi-daemon

RUN python3 -m pip install --upgrade pip wheel setuptools 
RUN python3 -m pip install aubio ledfx

# Expose the port
EXPOSE 8888
CMD ["ledfx"]
