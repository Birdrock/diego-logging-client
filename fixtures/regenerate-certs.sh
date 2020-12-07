#!/bin/bash

set -e

this_dir="$(cd $(dirname $0) && pwd)"

pushd "$this_dir"

rm -rf out
certstrap init --common-name "CA" --passphrase ""
certstrap request-cert --common-name "client" --domain "client" --passphrase ""
certstrap sign client --CA "CA"

certstrap request-cert --common-name "metron" --domain "metron" --passphrase ""
certstrap sign metron --CA "CA"

rm -rf ./metron
mkdir -p ./metron
mv -f out/* ./metron/
rm -rf out

popd
