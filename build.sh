#!/bin/sh
#Mr.Kitty
echo "Backing up..."

cd ..
endTime=$(date +%F_%H.%M.%S)
backupName="PhysPro-"$endTime".tar.bz2"
tar -jcvf $backupName "PhysPro-Nspire"
mv $backupName ./bk/

cd ./PhysPro-Nspire/

echo "Backup complete"
echo "Building PhysPro v0.8a..."
echo "Building the database"

cd 0\ -\ \ Database
./build.sh

#cd ..
#cd 1\ -\ \ Analysis\ Part
#./build.sh

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
echo "wine luna PhysProp.big.lua TestPhysPro.tns"
wine ./luna-v0.3a/luna.exe PhysPro.big.lua TestPhysPro.tns

echo "Done building PhysPro"

echo "Building definitions"
cd ./definitions
./build.sh
cd ..
echo "Done building definitions"

echo "Cleaning up"
rm lib.big.lua
rm FormulaPro.big.lua
#rm Analysis.big.lua
rm Reference.big.lua
rm Database.big.lua
#rm EEPro.big.lua

echo "Done. Enjoy!"

