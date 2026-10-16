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


Bootcamp Assignment 2: Validating tree-survey records

Purpose
This assignment uses Python to validate and clean a synthetic tree-survey dataset according to the supplied metadata. The program identifies invalid records, standardises permitted values, and counts accepted oak records by species.

Project Structure

README.md
.gitignore
code/
  unixPrac1.txt
  tabtocsv.sh
  csvtospace.sh
  clean_silwood_trees.py
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
  silwood_trees_metadata.md
  silwood_trees_raw.csv
results/
  oak_species_counts.csv
  silwood_tree_issues.csv
  silwood_trees_clean.csv    
sandbox/

Requirements
A UNIX-like terminal with Bash and common commands such as mkdir, tr
No Python packages are needed

Usage
Open the terminal and navigate to the project root directory:
cd ~/Documents/CMEECourseWork
Run python:
python3 code/clean_silwood_trees.py

Data
All data were supplied with the MulQuaBio MQB course materials: https://mulquabio.github.io/MQB/notebooks/python.html#practical-validating-tree-survey-records


AI Assistance
ChatGPT (OpenAI) was used to review previously learned Python concepts, provide hints for this coursework, and help identify and correct errors in the code.

Author
Isabel Zixiao Luo
email: izl26@ic.ac.uk