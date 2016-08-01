# docker-bitcoin
Docker bitcoin image

Create a bitcoin data container which mounts a directory with the blockchain:
```
$ docker create -v ~/Bitcoin:/data --name btcdata --entrypoint /bin/echo subotic/bitcoin Data-only
```


Run the bitcoin core container with the volume container connected. The dafault behaviour is to start
'bitcoind' on the live network. Also, if there is no 'bitcoin.conf', one will be created with an
'rpcuser' and a randomly generated 'rpcpassword':
```
$ docker run -d --name btccore -p 8333:8333 -p 18333:18333 --volumes-from btcdata subotic/bitcoin
```


To start 'bitcond' connected to the test network, you can run it with the '-testnet' flag:
```
$ docker run -d --name btccore -p 8333:8333 -p 18333:18333 --volumes-from btcdata subotic/bitcoin bitcoind -testnet
```

To comunicate with 'bitcoind', you can use ```docker exec```:
```
$ docker exec -it btccore bitcoin-cli getinfo
$ docker exec -it btccore stop
```