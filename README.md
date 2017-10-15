# memcached-munin-node
Docker image with memcached and munin-node
## How to use the image

```
docker run -d --name containername \ 
    -p 11211:11211 -e MEMORY_LIMIT=64 \
    defank/memcached-munin-node
```
`! Require ENV MEMORY_LIMIT !`
 
Default installed plugins munin-node:

* `memcached_bytes`
* `memcached_counters`
* `memcached_rates`

Logs path ``/var/log/supervisor``