# Caddy with Cloudflare Module

Caddy with integrated support for Cloudflare verification challenges via the Cloudflare module.

### Currently available images

Latest:
```
docker pull ghcr.io/kerimhudson/caddy-cloudflare:latest-alpine
```

```
docker pull ghcr.io/kerimhudson/caddy-cloudflare:2.8.1-alpine
```




This image builds using the caddy:alpine and caddy:builder-alpine images, and includes the [Cloudflare module](https://caddyserver.com/docs/modules/dns.providers.cloudflare). For more information about the build, I'd recommend you view the Dockerfile.

I use this image personally, but for safety and security I would recommend that you fork and build this for yourself if you wish to use it. 

The Github workflow to build uses variables and so will build the image based on your github username.

### Requirements

1. A Cloudflare account
2. A domain registered on your cloudflare account

Any domains you wish to use not registered with a Cloudflare account will need to use a different tls method. You can read more about TLS in Caddy [here](https://caddyserver.com/docs/caddyfile/directives/tls), and about modules in the [Caddy documentation](https://caddyserver.com/docs/modules).


### How to use this Docker image

1. Generate a Cloudflare Token

 Make sure to use a scoped API token, NOT a global API key. It will need two permissions: **Zone-Zone-Read** and **Zone-DNS-Edit**.

 2. Provide this token as an environment variable when using the Docker image, using something like `CLOUDFLARE_API_TOKEN`

 Examples:

 ```sh
 docker run -e CLOUDFLARE_API_TOKEN=your_token_value caddy-cloudflare:latest
 ```

 ```yml
 version: "3.7"

 services:
    caddy:
        image: caddy-cloudflare:latest
        environment:
            CLOUDFLARE_API_TOKEN: ${{ secrets.CLOUDFLARE_API_TOKEN }}

    ...
 ```

 3. Add the TLS definition to your Caddyfile

 For ease, I create a reusable block that can be used across all definitions.

 ```
 # Caddyfile 

 (cloudflare) {
    tls {
        dns cloudflare {env.CLOUDFLARE_API_TOKEN}
    }
}

example.com {
    import cloudflare
    respond "Hello, world"
}

 ```