FROM caddy:2.8.1-builder-alpine AS builder

LABEL org.opencontainers.image.description="Caddy with integrated support for Cloudflare verification challenges via the Cloudflare module"
LABEL org.opencontainers.image.licenses=MIT

RUN caddy-builder \
    github.com/caddy-dns/cloudflare

FROM caddy:2.8.1-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy