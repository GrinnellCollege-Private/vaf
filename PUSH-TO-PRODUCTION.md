To build and test a new image locally...

```
docker image build -t hugo-test .     # <-- executed from my project directory, builds a new up-to-date image
docker container run --rm -it -p 8081:80 hugo-test
http://localhost:8081
```

To push the new image to Docker Hub...

```
docker login
docker tag hugo-test mcfatem/vaf:latest
docker push mcfatem/vaf:latest
```

To launch the image as https://static.grinnell.edu/vaf see the gist at https://gist.github.com/McFateM/a008a99f25478cd6e73e463e769c7d75.

```
NAME=vaf
HOST=static.grinnell.edu
IMAGE="mcfatem/vaf"
docker container run -d --name ${NAME} \
    --label traefik.backend=${NAME} \
    --label traefik.docker.network=traefik_webgateway \
    --label "traefik.frontend.rule=Host:${HOST};PathPrefixStrip:/vaf" \
    --label traefik.port=80 \
    --label com.centurylinklabs.watchtower.enable=true \
    --network traefik_webgateway \
    --restart always \
${IMAGE}
```
