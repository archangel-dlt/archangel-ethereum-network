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

if [ "$ARCHANGEL_BOOTNODE" = "" ]; then
  ARCHANGEL_BOOTNODE="enode://21ceb67bc34760d8776b8adc3a60ecd54c9c7d609c4e54ba4c3ca5c2de08df587d224826f3cae9114952027327f5d23100eb61451c4b2a5ff14139c50ff65f20@139.162.253.192:30310"
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
  --bootnode)
  ARCHANGEL_BOOTNODE="${i#*=}"
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

ARCHANGEL_GENESIS_JSON="archangel-user-study-genesis.json"

if [ "$ARCHANGEL_ETHEREUM_ENABLE_RPC" = "true" ]; then
  RPC_ARGS="--rpc --rpcaddr $ARCHANGEL_ETHEREUM_RPC_HOST --rpcport $ARCHANGEL_ETHEREUM_RPC_PORT --rpcapi 'personal,db,eth,net,web3,txpool,miner'"
fi

# Initialise if necessary
if [ ! -f "$ARCHANGEL_ETHEREUM_DATA_DIR/geth/chaindata/CURRENT" ]; then
  echo $ARCHANGEL_ETHEREUM_GETH --datadir $ARCHANGEL_ETHEREUM_DATA_DIR --networkid 53419 init $SCRIPT_DIR/$ARCHANGEL_GENESIS_JSON
  $ARCHANGEL_ETHEREUM_GETH --datadir $ARCHANGEL_ETHEREUM_DATA_DIR --networkid 53419 init $SCRIPT_DIR/$ARCHANGEL_GENESIS_JSON
fi

# And off we go!
echo $ARCHANGEL_ETHEREUM_GETH \
  --datadir $ARCHANGEL_ETHEREUM_DATA_DIR \
  --networkid 53419 \
  --port $ARCHANGEL_ETHEREUM_PORT \
  --bootnodes $ARCHANGEL_BOOTNODE \
  $RPC_ARGS \
  $1 $2 $3 $4 $5 $6 $7 $8 $9
$ARCHANGEL_ETHEREUM_GETH \
  --datadir $ARCHANGEL_ETHEREUM_DATA_DIR \
  --networkid 53419 \
  --port $ARCHANGEL_ETHEREUM_PORT \
  --bootnodes $ARCHANGEL_BOOTNODE \
  $RPC_ARGS \
  $1 $2 $3 $4 $5 $6 $7 $8 $9
