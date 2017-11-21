mkdir traefik && cd traefik
wget https://raw.githubusercontent.com/ichasco/traefik/master/traefik.toml
docker network create traefik
docker run -d -p 8080:8080 -p 80:80 --network traefik --name traefik -v$PWD/traefik.toml:/etc/traefik/traefik.toml -v/var/run/docker.sock:/var/run/docker.sock traefik

