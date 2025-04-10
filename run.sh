#!/bin/bash

# Script to quickly compile, run, and cleanup C++ programs
# Wrote by DeepSeek + DeepThink
# Move it to PATH: chmod +x quickrun.sh && sudo mv run.sh /usr/local/bin/run

if [ $# -eq 0 ]; then
    echo "Usage: $0 <file.cpp> [g++ options...]"
    echo "Example 1: ./run.sh myapp.cpp"
    echo "Example 2: ./run.sh myapp.cpp -O3 -Wall -Wextra"
    exit 1
fi

cpp_file="$1"
shift  # Capture additional compiler flags

# Validate input file
if [ ! -f "$cpp_file" ]; then
    echo "Error: '$cpp_file' not found"
    exit 1
fi

if [[ "$cpp_file" != *.cpp ]]; then
    echo "Error: '$cpp_file' is not a .cpp file"
    exit 1
fi

# Extract base name for executable
base_name="${cpp_file%.cpp}"

# Compile with g++
if g++ "$cpp_file" -o "$base_name" "$@"; then
    # Ensure cleanup even if interrupted
    trap 'rm -f "$base_name"' EXIT INT TERM
    
    # Run with timing and capture exit code
    time ./"$base_name"
    exit_code=$?
    
    # Exit with program's status code
    exit $exit_code
else
    # Compilation failed
    exit 1
fi
