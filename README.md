#### Authentication by ssh-keypair
```
$ docker run --rm \
--publish=1337:22 \
--env KEYPAIR_LOGIN=true \
--volume /path/to/authorized_keys:/root/.ssh/authorized_keys \
sgcclh/kubectl
