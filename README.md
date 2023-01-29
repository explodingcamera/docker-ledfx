# LedFX Docker &nbsp; [![](https://ghcr-badge.deta.dev/explodingcamera/ledfx/size?tag=stable)](https://github.com/explodingcamera/docker-ledfx/pkgs/container/ledfx/59455876?tag=stable)

Simple Docker container for [LedFX](https://https://www.ledfx.app/).

## Tags

- `stable` - Latest stable release
- `v2.x.x` - Specific release version (updated weekly)

## Usage

### Docker

```bash
docker run -d \
    --name ledfx \
    --restart=always \
    -p 8888:8888 \
    -e PUID=1000 \
    -e PGID=1000 \
    # e.g give access to a usb sound card
    --device=/dev/snd \
    -v /path/to/config:/home/ledfx/.ledfx/config.json \
    ghcr.io/explodingcamera/ledfx:stable
```

## Environment variables

- `PUID` - User ID (default: `1000`)
- `PGID` - Group ID (default: `1000`)
