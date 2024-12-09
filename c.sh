#!/bin/bash

# Check if the file name is provided
if [ -z "$1" ]; then
  echo "Usage: ./c.sh <filename.cpp>"
  exit 1
fi

# Extract file name without extension
filename="${1%.*}"

# Compile the C++ file with g++
echo "Compiling $1..."
g++ -O2 -std=c++14 -w -o "$filename" "$1"

# Check if compilation was successful
if [ $? -eq 0 ]; then
  echo "Compilation successful. Running $filename..."
  echo "------------------------------"
  ./"$filename"
  echo
  echo "------------------------------"
  rm "$filename"
else
  echo "Compilation failed."
fi
