
$ARCHANGEL_ETHEREUM_GETH="geth"
$ARCHANGEL_ETHEREUM_DATA_DIR="$pwd\ethereum"
$ARCHANGEL_ETHEREUM_PORT=30303
$ARCHANGEL_ETHEREUM_ENABLE_RPC="true"
$ARCHANGEL_ETHEREUM_RPC_HOST="localhost"
$ARCHANGEL_ETHEREUM_RPC_PORT=8545
$ARCHANGEL_BOOTNODE="enode://21ceb67bc34760d8776b8adc3a60ecd54c9c7d609c4e54ba4c3ca5c2de08df587d224826f3cae9114952027327f5d23100eb61451c4b2a5ff14139c50ff65f20@139.162.253.192:30310"

if ($ARCHANGEL_ETHEREUM_ENABLE_RPC -eq "true") {
  $RPC_ARGS=@("--rpc", "--rpcaddr", $ARCHANGEL_ETHEREUM_RPC_HOST, "--rpcport", $ARCHANGEL_ETHEREUM_RPC_PORT, "--rpcapi", "personal,db,eth,net,web3,tx,poolminer")
}

# Initialise if necessary
if (!(Test-Path "$ARCHANGEL_ETHEREUM_DATA_DIR\geth\chaindata\CURRENT")) {
 Write-Host "Initialising with Archangel Genesis block"
 & $ARCHANGEL_ETHEREUM_GETH --datadir $ARCHANGEL_ETHEREUM_DATA_DIR init $pwd\archangel-genesis.json
}

# And off we go!
Write-Host "Starting Archangel Ethereum network client"
& $ARCHANGEL_ETHEREUM_GETH `
  --datadir $ARCHANGEL_ETHEREUM_DATA_DIR `
  --networkid 53419 `
  --port $ARCHANGEL_ETHEREUM_PORT `
  --bootnodes $ARCHANGEL_BOOTNODE
  $RPC_ARGS `
  $1 $2 $3 $4 $5 $6 $7 $8 $9
