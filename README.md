# docker-cronicle

```
docker rm -f cronicle; \
docker run -d \
--name cronicle \
--hostname cronicle.example.com \
-e TZ=Europe/Prague \
-e CRONICLE_base_app_url='http://cronicle.example.com' \
-e CRONICLE_custom_live_log_socket_url='http://cronicle.example.com' \
-v /var/run/docker.sock:/var/run/docker.sock \
-v cronicle:/opt/cronicle/data \
-v /usr/bin/docker:/opt/cronicle/plugins/docker:ro \
-p 3012:3012 \
cronicle
```

# traefik labels
```
--label "traefik.enable=true" \
--label "traefik.basic.frontend.rule=Host:cronicle.example.com" \
--label "traefik.basic.port=3012" \
```
