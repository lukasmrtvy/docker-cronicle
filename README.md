# docker-cronicle

```
docker rm -f cronicle; \
docker run -d \
--name cronicle \
--hostname cronicle.example.com \
-e TZ=Europe/Prague \
-e SETUP_CONFIG=true \
-e CRONICLE_base_app_url='http://cronicle.example.com' \
-e CRONICLE_server_comm_use_hostnames=1 \
-e CRONICLE_web_socket_use_hostnames=1 \
-v /var/run/docker.sock:/var/run/docker.sock \
-p 3012:3012 \
cronicle
```
