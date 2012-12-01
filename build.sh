#!/bin/bash

#Mr.Kitty

echo "Building $1" 

if [[ "$3" = -b ]]; then
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

if [[ "$1" = "-luna" ]]; then
    echo "Building PhysPro v0.1a..."
    
    echo "Building the Database"
    cat 0\ -\ \ Database/*.lua > build/big/Database.big.lua
    
    # echo "Building the analysis"
    # cat 1\ -\ \ Analysis\ Part/*.lua > /build/big/Analysis.big.lua
    
    echo "Building the FormulaPro core"
    cat 2\ -\ \ FormulaPro/*.lua > build/big/FormulaPro.big.lua
    
    echo "Building Reference"
    cd ..
    cat 3\ -\ \ Reference Part/*.lua > build/big/Reference.big.lua
    
    echo "Building the libraries"
    cd Global\ Libraries
    cat globals.lua animation.lua screen.lua widgets.lua > ../build/big/lib.big.lua
    cd ..
    
    echo "Creating the whole thing..."
    cd build/big/
    cat Database.big.lua lib.big.lua FormulaPro.big.lua Reference.big.lua main.lua > PhysPro.big.lua
    cd ..
    wine /luna/luna.exe big/PhysPro.big.lua PhysPro-Nspire.tns
    mv PhysPro-Nspire.tns PhysPro-Nspire.tns
    echo "Done building PhysPro"
elif [[ "$1" = "-etk" ]]; then
    cd ./
fi

if [[ "$2" = "-o" ]]; then
    open ./Files/PhysPro-Nspire.tns
fi

echo ""
echo "Done. Enjoy!"

