#!/bin/bash
# Author: izl26@imperial.ac.uk
# Script: csvtospace.sh
# Desc: converts a comma-separated input into a space-separated output
#       saves the output into a .txt file
# Arguments: 1-> comma delimited file
# Date: Oct 2026



if [ "$#" -ne 1 ]; then
    echo "Error. Accept exactly one readable CSV input file." >&2
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "Error. Input file is missing." >&2
    exit 1
fi

if [ ! -r "$1" ]; then
    echo "Error. Input file is not readable." >&2
    exit 1
fi

filename=$(basename "$1")

mkdir -p ../results

if ! tr "," " " < "$1" > "../results/${filename}.txt"; then
    echo "Error. Failed." >&2
    exit 1
fi

echo "Done!"




