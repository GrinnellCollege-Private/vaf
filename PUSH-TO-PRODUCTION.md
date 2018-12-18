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

To launch the image as https://vaf.grinnell.edu use this:

```
NAME=vaf
HOST=vaf.grinnell.edu
IMAGE="mcfatem/vaf"
docker container run -d --name ${NAME} \
    --label traefik.backend=${NAME} \
    --label traefik.docker.network=traefik_webgateway \
    --label "traefik.frontend.rule=Host:${HOST}" \
    --label traefik.port=80 \
    --label com.centurylinklabs.watchtower.enable=true \
    --network traefik_webgateway \
    --restart always \
${IMAGE}
```


Original TIFF images are held in `static/images/originals`.  I used https://hackernoon.com/save-time-by-transforming-images-in-the-command-line-c63c83e53b17 and *Imagemagick*'s `mogrify` and `convert` commands to produce the thumbnail and full-size images found in `static/images/thumbs` and `static/images/full`, respectively.

Resizing was based on a 7x5 (horizontal x vertical) grid and assumed use of a 3rd or 4th generation Apple iPad with screen resolution of 2048x1536 (landscape).  Thumbnail size is 280x280 pixels and full-size are 1250x1250.  

## Kiosk
The new specs say the block arrangement will be 5 wide x 7 tall, and that should work nicely for an iPad kiosk in a *portrait* orientation.  However, when we emulate this the thumbnails appear to be twice as wide as necessary, only 2 will fit side-by-side on the iPad screen.  So, on 7-Dec-2018 I created a new local `half-size` branch of the project and hit the `static/images/thumbs` folder with:

```
mogrify -resize 50% *.png
```

I also found that the banner image was too wide for the iPad so I hit the `static/images` directory with:

```
mogrify -resize 75% *.png
```
