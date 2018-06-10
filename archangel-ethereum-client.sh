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
  --bootnodes enode://98d6401f594cd1e68de946680f009bcb504f61c5e755dc37e548c59b9dcc4651c30f74aaffb3f88c87ec240c763180a3ae113b125c6166dc23af8d3f6fd0a89c@172.104.142.159:30301 \
  $RPC_ARGS \
  $1 $2 $3 $4 $5 $6 $7 $8 $9
