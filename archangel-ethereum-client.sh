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

if [ "$ARCHANGEL_ETHEREUM_ENABLE_RPC" = "" ]; then
  ARCHANGEL_ETHEREUM_ENABLE_RPC=true
fi

if [ "$ARCHANGEL_ETHEREUM_RPC_HOST" = "" ]; then
  ARCHANGEL_ETHEREUM_RPC_HOST=localhost
fi

if [ "$ARCHANGEL_ETHEREUM_RPC_PORT" = "" ]; then
  ARCHANGEL_ETHEREUM_RPC_PORT=8545
fi

for i in "$@"
do
case $i in
  --geth=*)
  ARCHANGEL_ETHEREUM_GETH="${i#*=}"
  shift
  ;;
  --datadir=*)
  ARCHANGEL_ETHEREUM_DATA_DIR="${i#*=}"
  shift
  ;;
  --port=*)
  ARCHANGEL_ETHEREUM_PORT="${i#*=}"
  shift
  ;;
  --rpcaddr=*)
  ARCHANGEL_ETHEREUM_RPC_HOST="${i#*=}"
  shift
  ;;
  --rpcport=*)
  ARCHANGEL_ETHEREUM_RPC_PORT="${i#*=}"
  shift
  ;;
  --no-rpc)
  ARCHANGEL_ETHEREUM_ENABLE_RPC=false
  shift
  ;;
  --)
  shift
  break
  ;;
  *)
  echo Unknown argument $i
  ;;
esac
done


if [ "$ARCHANGEL_ETHEREUM_ENABLE_RPC" = "true" ]; then
  RPC_ARGS="--rpc --rpcaddr $ARCHANGEL_ETHEREUM_RPC_HOST --rpcport $ARCHANGEL_ETHEREUM_RPC_PORT --rpcapi 'personal,db,eth,net,web3,txpool,miner'"
fi

# Initialise if necessary
if [ ! -f "$ARCHANGEL_ETHEREUM_DATA_DIR/geth/chaindata/CURRENT" ]; then
  $ARCHANGEL_ETHEREUM_GETH --datadir $ARCHANGEL_ETHEREUM_DATA_DIR init $SCRIPT_DIR/archangel-genesis.json
fi

# And off we go!
$ARCHANGEL_ETHEREUM_GETH \
  --datadir $ARCHANGEL_ETHEREUM_DATA_DIR \
  --networkid 3151 \
  --port $ARCHANGEL_ETHEREUM_PORT \
  --bootnodes enode://6bdb4cf6385b437c04bba1853f4bcaa519328d615ea5d0a1050c7689c7cfbaee8a6617aafc48cb1ab554328bce6e6ea6a12bdef6b1a5dd877259bf99cebe4d22@139.162.253.192:30303 \
  $RPC_ARGS \
  $1 $2 $3 $4 $5 $6 $7 $8 $9
