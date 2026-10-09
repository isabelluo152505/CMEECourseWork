Bootcamp Assignment 1: Unix, Shell and Git

Project purpose
This repository contains my UNIX practical answers and shell scripts for simple text file conversions. The FASTA file gives one single-line UNIX command for each numbered answer, with a short explanation of what it does. The scripts convert tab-seperated input to comma-separated output (tabtocsv,sh) and comma-separated input to space-separated output(csvtospace.sh)

Project structure

README.md
.gitignore
code/
  unixPrac1.txt
  tabtocsv.sh
  csvtospace.sh
data/
  fasta/
    407228326.fasta
    407228412.fasta
    e_coli.fasta
  temperatures/
    1800.csv
    1801.csv
    1802.csv
    1803.csv
  tab-example.tsv
results/    
sandbox/  

Requirements
A UNIX-like terminal with Bash and common commands such as mkdir, tr
Run the scripts from the code/directory
No Python packages are needed


Usage
From the repository root:
cd code
bash tabtocsv.sh ../data/tab-example.tsv
bash csvtospace.sh ../data/temperatures/1800.csv
bash csvtospace.sh ../data/temperatures/1801.csv
bash csvtospace.sh ../data/temperatures/1802.csv
bash csvtospace.sh ../data/temperatures/1803.csv

Data 
The FASTA and temperature data were supplied with the MulQuaBio MQB course materials: https://github.com/MulQuaBio/MQB
tab-example.tsv is a small example I created myself to test tabtocsv.sh scripts.

Authors
Isabel Zixiao Luo
email: izl26@ic.ac.uk