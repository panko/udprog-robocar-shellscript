#!/bin/bash
# robocar auto

mkdir temp
cd temp
git clone https://code.google.com/p/robocar-emulator/
cd robocar-emulator/justine/rcemu
autoreconf --install
./configure
make
cd ../rcwin
mvn clean compile package site assembly:assembly
