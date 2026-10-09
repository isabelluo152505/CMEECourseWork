#!/bin/bash
# Author: izl26@imperial.ac.uk
# Script: tabtocsv.sh
# Desc: substitute the tabs in the files with commas
#       saves the output into a .csv file
# Arguments: 1-> tab delimited file
# Date: Oct 2026


if [ "$#" -ne 1 ]; then
    echo "Error. Accept exactly one readable tab-delimited input file." >&2
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

echo "Creating a comma delimited version of $1 ..."

filename=$(basename "$1")

mkdir -p ../results

if ! tr "\t" "," < "$1" > "../results/${filename}.csv"; then
    echo "Error. Failed." >&2
    exit 1
fi

echo "Done!"

exit