#!/bin/bash

SCRIPT_DIR=`dirname "$0"`

if [ "$ARCHANGEL_ETHEREUM_GETH" = "" ]; then
  ARCHANGEL_ETHEREUM_GETH=geth
fi

if [ "$ARCHANGEL_ETHEREUM_DATA_DIR" = "" ]; then
  ARCHANGEL_ETHEREUM_DATA_DIR=$SCRIPT_DIR/ethereum
fi

if [ "$ARCHANGEL_ETHEREUM_PORT" = "" ]; then
  ARCHANGEL_ETHEREUM_PORT=30303
fi

if [ "$ARCHANGEL_ETHEREUM_RPC_HOST" = "" ]; then
  ARCHANGEL_ETHEREUM_RPC_HOST=localhost
fi

if [ "$ARCHANGEL_ETHEREUM_RPC_PORT" = "" ]; then
  ARCHANGEL_ETHEREUM_RPC_PORT=8545
fi

if [ "$1" != "--no-rpc" ]; then
  RPC_ARGS="--rpc --rpcaddr $ARCHANGEL_ETHEREUM_RPC_HOST --rpcport $ARCHANGEL_ETHEREUM_RPC_PORT --rpcapi 'personal,db,eth,net,web3,txpool,miner'"
else
  shift 1
fi

# run the Geth client
if [ ! -f "$ARCHANGEL_ETHEREUM_DATA_DIR/geth/chaindata/CURRENT" ]; then
  $ARCHANGEL_ETHEREUM_GETH --datadir $ARCHANGEL_ETHEREUM_DATA_DIR init $SCRIPT_DIR/archangel-genesis.json
fi

$ARCHANGEL_ETHEREUM_GETH \
  --datadir $ARCHANGEL_ETHEREUM_DATA_DIR \
  --networkid 3151 \
  --port $ARCHANGEL_ETHEREUM_PORT \
  --bootnodes enode://6bdb4cf6385b437c04bba1853f4bcaa519328d615ea5d0a1050c7689c7cfbaee8a6617aafc48cb1ab554328bce6e6ea6a12bdef6b1a5dd877259bf99cebe4d22@139.162.253.192:30303 \
  $RPC_ARGS \
  $1 $2 $3 $4 $5 $6 $7 $8 $9
