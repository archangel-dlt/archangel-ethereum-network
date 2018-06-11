# Archangel

Script to run a node on the Archangel private Ethereum network

## Pre-requisites

Using this script requires [Geth](https://ethereum.github.io/go-ethereum/install/), the Go Ethereum client.

## Running the client

```sh
 ./archangel-ethereum-network.sh
```

The script will, if necessary, initialise the genesis block.

By default, the script will
  * Store its data in a directory immediately below the script's location
  * Use port 30303 for incoming connections from the Archangel Ethereum network
  * Listen on localhost:8545 for RPC API requests (eg from MetaMask)

These defaults can be override using environment variables or command line arguments :

* `ARCHANGEL_ETHEREUM_DATA_DIR=<directory>`, `--datadir=<directory>`
* `ARCHANGEL_ETHEREUM_PORT=<port number>`, `--port=<port number>`
* `ARCHANGEL_ETHEREUM_RPC_HOST=<rpc hostname or ip>`, `--rpchost=<rpc hostname or ip>`
* `ARCHANGEL_ETHEREUM_RPC_PORT=<rpc port number>`, `--rpcport=<rpc port number>`


If an environment variable is set and the equivalent command line argument passed, then the command line argument will be used.

There are two additional options :
* `ARCHANGEL_ETHEREUM_GETH=<path to geth>`, `--geth=<path to geth>`

The script expects to find `geth` on the path.  However, if you have it installed elsewhere use this option to let the script know.

* `ARCHANGEL_ETHEREUM_ENABLE_RPC=no`, `--no-rpc`

Use this option to turn off the RPC API listener.

* `--`

The special option `--` marks the end of the options. The script will pass any arguments after `--` directly to geth.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/archangel-dlt/archangel-ethereum-network.

## Code of Conduct

Everyone interacting in the Archangel project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/archangel-dlt/archangel-ethereum-network/blob/master/CODE_OF_CONDUCT.md).

## License

This software is available under the terms of [the MIT License](https://github.com/archangel-dlt/archangel-ethereum-network/blob/master/LICENSE.md).
