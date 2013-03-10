#!/bin/bash

function EXIT (){
    unset ARGS
}

ARGS="$@"

if [[ "$ARGS" == *"-luna"* ]]; then
    echo "Building PhysPro-Nspire..."

    [[ ! -d "build/big" ]] && mkdir build/big

    echo "Building the database"
    cat database/*.lua > build/big/database.big.lua

    # echo "Building the analysis"
    # cat analysis/*.lua > /build/big/analysis.big.lua

    echo "Building the FormulaPro core"
    cat FormulaPro/*.lua > build/big/formulapro.big.lua

    echo "Building the reference"
    cat reference/*.lua > build/big/reference.big.lua

    echo "Building the libraries"
    cat lib/*.lua > build/big/lib.big.lua

    echo "Creating the whole thing..."
    cd build/big/
    cat database.big.lua lib.big.lua formulapro.big.lua reference.big.lua ../../main.lua > ../PhysPro.src.lua
    cd ..
    luna PhysPro.src.lua PhysPro-Nspire.tns
    cp PhysPro.src.lua PhysPro.src.lua.tns
    echo "Done building PhysPro"
elif [[ "$ARGS" == *"-etk"* ]]; then
    build/etk.lua main.lua build/PhysPro-Nspire.tns
    cp build/PhysPro.src.lua build/PhysPro.src.lua.tns
fi

if [[ "$ARGS" == *"-send"* ]]; then
    echo "WIP"; exit 99
    # tilp --transfer_to_nspire build/PhysPro-Nspire.tns
elif [[ "$ARGS" == *"-open"* ]]; then
    open PhysPro-Nspire.tns
fi

echo "Done. Enjoy!"

