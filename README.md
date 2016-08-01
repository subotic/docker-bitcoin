# docker-bitcoin
Docker bitcoin image

Create a bitcoin data container which mounts a directory with the blockchain
```
$ docker create -v ~/Bitcoin:/data --name btcdata --entrypoint /bin/echo subotic/bitcoin Data-only
```

Run the bitcoin core container with the volume container connected. The dafault behaviour is to start
bitcoin core with the '-server' flag. Also, if there is no 'bitcoin.conf', one will be created with an
'rpcuser' and a randomly generated 'rpcpassword'.
```
$ docker run -d --name btccore -p 8333:8333 -p 18333:18333 --volumes-from btcdata subotic/bitcoin
```