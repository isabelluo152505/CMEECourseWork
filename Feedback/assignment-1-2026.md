# Assignment 1 feedback - Isabel Luo

**Formative feedback | Rubric 2026.2**

All five FASTA answers matched the independent checks. Q3's subtraction of newline bytes from the header-free byte count is a valid alternative for these supplied ASCII/LF files, and the ratio explanation records why decimal division was needed. Your own TSV includes an empty field, and the converters have useful readable-file and conversion-status checks.

The converters still assume code/ as the starting directory through ../results. Make them work from the repository root, explicitly check directory creation and update the README examples. Then try a fresh checkout with no results directory already present.

Several generated conversion files are committed. That prevented some corresponding fresh-output checks from running: an old result cannot establish that the current script creates it correctly. Untrack generated outputs and ignore results/, keeping the original inputs. Repeat the affected tests after this cleanup.

The README has a useful task map, but needs specific expected/observed tests, the bc dependency and any help account. Keep the explanations of length, motif and ratio rather than reducing them to result values. For future changes, use smaller descriptive commits instead of broad week1/re-upload messages; someone should be able to see which path, test or explanation a revision corrected.

---

## Project structure

Relevant tracked layout (simplified; missing required paths are marked):

```text
README.md
.gitignore
code/  unixPrac1.txt, tabtocsv.sh, csvtospace.sh
data/fasta/  3 required files present
data/temperatures/  4 required files present
data/tab-example.tsv
results/  6 files tracked
sandbox/  no files tracked; optional
```

All required root files, code and input paths are present. Six files are tracked under results/, including an oddly named .csv file and the converted supplied/own inputs. The ignore file currently covers only temporary filename patterns.

Untrack generated outputs and add a results rule, preserving the original input files. The .csv artifact is not a required input; check its purpose rather than retaining it simply because it exists. Keep the existing code/data split and make the README point to the corrected root-based output location.

**Assessed snapshot:** `b6ee7108497af78550232981cf5ae342e249fa3d`
