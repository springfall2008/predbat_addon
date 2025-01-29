I thought I should create my own fork to log the changes and files needed to run the docker images for predbat_addon, so here it is:

# Predbat Home Assistant Add-on (Docker)

This Git repository provides the foundation for creating and modifying the Predbat addon for Docker.  
The builds are hosted on Docker Hub, available for anyone and are created using the appropriate `dockerfile.OS` for each distribution.

---

## Available Builds and Linux Distributions

The following options are available:  
- **Noble**: A standard version closely aligned with the Predbat addon for Home Assistant.  
- **Alpine** and **Slim**: Lightweight versions optimized to reduce size.

---

## Key Notes

- Modifications are limited to the run and startup scripts, which serve as a transport mechanism for running the Predbat application.  
- The core application files remain unaltered.  
- Any Predbat-related issues should be reported in the [Predbat GitHub repository](#).

---

## Installation

You can run each build either as a self-contained Docker container or with mounted bind points for easy access to configuration files and logs.  

By default, the container operates in the root Docker context. This can be customized during installation by specifying the `predbat` user within the command or the Docker Compose file.

---

### Command-Line Installation with Mount Points

```bash
docker run -d --name predbat \
  -v /path/to/local/config:/config \
  -v /etc/localtime:/etc/localtime \
  nipar44/predbat_addon:tag
```

## Steps:

1. Replace /path/to/local/config with the full path to your local configuration directory.
2. Replace tag with the desired version of the image (e.g., alpine-latest or noble).

## Docker Compose
For a more structured and easily repeatable setup, use a docker-compose.yml file.

```yaml
services:
  predbat:
    container_name: predbat
    image: nipar44/predbat_addon:tag
    restart: unless-stopped
    ports:
      - 5052:5052
    user: predbat
    volumes:
      - /path/to/local/config:/config:rw
      - /etc/localtime:/etc/localtime:ro
```
See Steps above for required modifications
