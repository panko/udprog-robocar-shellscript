#!/bin/bash
# install packages debian jessie for robocar

# you haveto have sudo, important

sudo apt-get update

sudo apt-get install git dh-autoreconf pkg-config libboost-all-dev flex cmake maven libprotobuf-dev protobuf-compiler zlib1g-dev libbz2-dev openjdk-7-jdk

# osm bin
mkdir OSM-binary
cd OSM-binary/
git clone https://github.com/scrosby/OSM-binary.git
cd OSM-binary/
make -C src
sudo make -C src install

# libosm
mkdir libosmium
cd libosmium/
git clone https://github.com/osmcode/libosmium.git
cd libosmium/
cmake .
make
sudo make install
