FROM ethereum/client-go:v1.8.23

RUN apk update && apk add bash

RUN addgroup -g 98765 archangel  && \
    adduser -D -G archangel -u 98765 -s /bin/bash archangel

WORKDIR /home/archangel

ADD archangel-user-study-genesis.json archangel-ethereum-client.sh ./

RUN chown -R archangel:archangel . 

USER archangel

ENV ARCHANGEL_ETHEREUM_DATA_DIR=/home/archangel/.ethereum \
    ARCHANGEL_BOOTNODE=enode://451de7fe15bfec8e8e2d4cbeb5f4306c6cd6cc052085da90f66f672f5a87182e9cbfa2a4a15352944d506e68d7540322e0b424217fd4055244c34540469e5858@139.162.253.192:30303 \
    ARCHANGEL_ETHEREUM_RPC_API='eth,net,web3'

ENTRYPOINT ["./archangel-ethereum-client.sh"]