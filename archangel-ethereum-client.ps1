
$ARCHANGEL_ETHEREUM_GETH="geth"
$ARCHANGEL_ETHEREUM_DATA_DIR="$pwd\ethereum"
$ARCHANGEL_ETHEREUM_PORT=30303
$ARCHANGEL_ETHEREUM_ENABLE_RPC="true"
$ARCHANGEL_ETHEREUM_RPC_HOST="localhost"
$ARCHANGEL_ETHEREUM_RPC_PORT=8545

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
  --networkid 3151 `
  --port $ARCHANGEL_ETHEREUM_PORT `
  --bootnodes enode://98d6401f594cd1e68de946680f009bcb504f61c5e755dc37e548c59b9dcc4651c30f74aaffb3f88c87ec240c763180a3ae113b125c6166dc23af8d3f6fd0a89c@172.104.142.159:30301 ` `
  $RPC_ARGS `
  $1 $2 $3 $4 $5 $6 $7 $8 $9

