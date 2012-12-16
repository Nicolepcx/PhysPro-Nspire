#!/bin/bash


echo "Building with $1"

if [[ "$3" = -b ]]; then
    echo "Backing up..."
    cd ..
    endTime=$(date +%F_%H.%M.%S)
    backupName="PhysPro-"$endTime".tar.bz2"
    tar -jcvf $backupName "PhysPro-Nspire"
    --mv $backupName bk/
    cd PhysPro-Nspire/
    echo "Backup complete"
fi

if [[ "$1" = "-luna" ]]; then
    echo "Building PhysPro-Nspire..."

    echo "Building the Database"
    cat 0\ -\ \ Database/*.lua > build/big/database.big.lua

    # echo "Building the analysis"
    # cat 1\ -\ \ Analysis\ Part/*.lua > /build/big/analysis.big.lua

    echo "Building the FormulaPro core"
    cat 2\ -\ \ FormulaPro/*.lua > build/big/formulapro.big.lua

    echo "Building Reference"
    cat 3\ -\ \ Reference\ Part/*.lua > build/big/reference.big.lua

    echo "Building the libraries"
    cat Global\ Libraries/*.lua > ../build/big/lib.big.lua

    echo "Creating the whole thing..."
    cd build/big/
    cat database.big.lua lib.big.lua formulapro.big.lua reference.big.lua ../../main.lua > ../PhysPro.big.lua
    cd ..
    wine luna/luna.exe PhysPro.big.lua PhysPro-Nspire.tns
    echo "Done building PhysPro"
elif [[ "$1" = "-etk" ]]; then
    echo "No done yet"
fi

if [[ "$2" = "-o" ]]; then
    open PhysPro-Nspire.tns
fi

echo "Done. Enjoy!"

