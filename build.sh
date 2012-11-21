#!/bin/bash

#Mr.Kitty

echo "Building $1" 

if [[ "$2" = -b ]]; then
    echo "Backing up..."
    cd ..
    endTime=$(date +%F_%H.%M.%S)
    backupName="PhysPro-"$endTime".tar.bz2"
    tar -jcvf $backupName "PhysPro-Nspire"
    mv $backupName ./bk/
    cd ./PhysPro-Nspire/
    echo "Backup complete"
else
    echo "WARNING: A backup was not created."
fi

if [[ "$1" = "-physpro" || "$1" = "-a" ]]; then
    echo ""
    echo "Building PhysPro v0.1a..."
    
    echo "Building the database"
    cd 0\ -\ \ Database
    ./build.sh
    
    # echo "Building the analysis"
    # cd ..
    # cd 1\ -\ \ Analysis\ Part
    # ./build.sh
    
    echo "Building the FormulaPro core"
    cd ..
    cd 2\ -\ \ FormulaPro
    ./build.sh
    
    echo "Building Reference"
    cd ..
    cd 3\ -\ \ Reference\ Part
    ./build.sh
    
    echo "Building the libraries"
    cd ..
    cd Global\ Libraries
    ./build.sh
    cd ..
    
    echo "Creating the whole thing..."
    cat Database.big.lua lib.big.lua FormulaPro.big.lua Reference.big.lua main.lua > PhysPro.big.lua
    echo "wine luna PhysPro.big.lua PhysPro-Nspire.tns"
    wine ../../luna-v0.3a/luna.exe PhysPro.big.lua PhysPro-Nspire.tns
    mv PhysPro-Nspire.tns ./Files/PhysPro-Nspire.tns
    echo "Done building PhysPro"

    echo "Cleaning up"
    rm lib.big.lua
    rm FormulaPro.big.lua
    #rm Analysis.big.lua
    rm Reference.big.lua
    rm Database.big.lua
fi

if [[ "$1" = "-definitions" || "$1" = "-a" ]]; then
    echo ""
    
    echo "Building definitions"
    cd ./definitions
    ./build.sh
    cd ..
    echo "wine luna definitions.big.lua definitions.tns"
    wine ../../luna-v0.3a/luna.exe definitions.big.lua definitions.tns
    mv definitions.tns ./Files/definitions.tns
    echo "Done building definitions"
fi

if [[ "$3" = "-o" ]]; then
    open ./Files/PhysPro-Nspire.tns
fi

echo ""
echo "Done. Enjoy!"

