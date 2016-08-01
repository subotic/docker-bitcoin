# Pull base image.
FROM ubuntu:14.04

MAINTAINER Ivan Subotic <ivan.subotic@unibas.ch>

# Silence debconf messages
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

ENV BITCOIN_VERSION 0.12.1
ENV BITCOIN_URL https://bitcoin.org/bin/bitcoin-core-0.12.1/bitcoin-0.12.1-linux64.tar.gz
ENV BITCOIN_ASC_URL https://bitcoin.org/bin/bitcoin-core-$BITCOIN_VERSION/SHA256SUMS.asc

# Install.
RUN set -ex && \
    apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates wget && \
    rm -rf /var/lib/apt/lists/* && \

    # install bitcoin binaries
    BITCOIN_DIST=$(basename $BITCOIN_URL) && \
    wget -O $BITCOIN_DIST $BITCOIN_URL && \
    gpg --keyserver pool.sks-keyservers.net --recv-keys 01EA5486DE18A882D4C2684590C8019E36C2E964 && \
    wget -qO bitcoin.asc $BITCOIN_ASC_URL && \
    gpg --verify bitcoin.asc && \
    tar -xzvf $BITCOIN_DIST -C /usr/local --strip-components=1 --exclude=*-qt && \
    rm bitcoin* && \

    # remove build dependencies
    apt-get purge -y --auto-remove wget

ENV BITCOIN_DATA /data
RUN mkdir $BITCOIN_DATA && \
    ln -s $BITCOIN_DATA $HOME/.bitcoin
VOLUME /data

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8333 18333
CMD ["bitcoind"]