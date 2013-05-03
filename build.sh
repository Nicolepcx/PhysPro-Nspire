#!/bin/bash

ARGS="$@"

build/etk.lua main.lua build/PhysPro-Nspire.tns
cp build/PhysPro.src.lua build/PhysPro.src.lua.tns

if [[ "$ARGS" == *"-send"* ]]; then
    echo "WIP"; exit 99
    # tilp --transfer_to_nspire build/PhysPro-Nspire.tns
elif [[ "$ARGS" == *"-open"* ]]; then
    open "/Applications/TI-Nspire Student Software.app"
    open "PhysPro-Nspire.tns"
fi

echo "Done. Enjoy!"

