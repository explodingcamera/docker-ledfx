# LedFX Docker

> Simple Docker container for [LedFX](https://https://www.ledfx.app/). <br/>
>
> `ghcr.io/explodingcamera/ledfx:latest`

## Tags

- `latest` - Latest stable release
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
    ghcr.io/explodingcamera/ledfx:latest
```

## Environment variables

- `PUID` - User ID (default: `1000`)
- `PGID` - Group ID (default: `1000`)
