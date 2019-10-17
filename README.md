# docker-cronicle

ENV variables: https://github.com/jhuckaby/Cronicle#environment-variables

```
docker run -d \
--name cronicle \
--hostname cronicle.example.com \
-e TZ=Europe/Prague \
-e CRONICLE_base_app_url='http://cronicle.example.com' \
-e CRONICLE_custom_live_log_socket_url='http://cronicle.example.com' \
-v /var/run/docker.sock:/var/run/docker.sock \
-v cronicle:/opt/cronicle/data \
-v /foo/bar/plugins:/opt/cronicle/plugins:ro \
-p 3012:3012 \
--network private-network \
cronicle
```

# traefik labels
```
--label "traefik.enable=true" \
--label "traefik.basic.frontend.rule=Host:cronicle.example.com" \
--label "traefik.basic.port=3012" \
```

# docker proxy
```
docker run -d \
    --privileged \
    --name dockerproxy \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --network private-network \
    tecnativa/docker-socket-proxy
```

# run container from Cronicle ( didn ) -> job example
```
curl \
  --silent \
  http://dockerproxy:2375 \
  "http:/containers/create?name=foobar" \
  -X POST \
  -H "Content-Type: application/json" \
  -d '{ "Image": "alpine:latest", "Cmd": [ "echo", "hello world" ] }' | jq '.'
```
