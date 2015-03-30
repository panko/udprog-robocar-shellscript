#!/bin/sh
if [ $# -ne 1 ]
   # "$#" is number of parameters- here we test
   # whether it is not equal to two
   then
   echo "You have to tell the map.\nUsage: $0 <maporcallitwhateveryouwant.osm>  "	# not one parameter
   # so print message
   exit 2             		# and fail ($0 is
   # name of command).
   fi
cp $1 temp/robocar-emulator/justine

cd temp/robocar-emulator/justine/rcemu
filename=$(basename "$1")
filename="${filename%.*}"
echo "Use $filename as city."
src/smartcity --osm=../$1 --city=${filename} --shm=${filename}SharedMemory --node2gps=../${filename}-lmap.txt &
sleep 8

cat ../${filename}-lmap.txt | sed 's/\./,/g' > temp.txt; mv temp.txt ../${filename}-lmap.txt

src/traffic --port=10007 --shm=${filename}SharedMemory &
sleep 5
cd ../rcwin
java -jar target/site/justine-rcwin-0.0.16-jar-with-dependencies.jar ../${filename}-lmap.txt &
(sleep 1; echo "<init Norbi 500 g>"; sleep 1)|telnet localhost 10007
echo 'Added gangstarz.';sleep 5
../rcemu/src/samplemyshmclient --port=10007 --shm=${filename}SharedMemory --team=${filename}Police 
