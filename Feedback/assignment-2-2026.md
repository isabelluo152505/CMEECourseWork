# Assignment 2 formative feedback

This feedback is organised by the relevant computing bootcamp criteria. Use it to decide what is already working, what you need to investigate, and what to revise before the cumulative submission.

The full criteria are in the [Computing Bootcamp assessment rubric](https://github.com/MulQuaBio/MQB/blob/main/content/rubrics/Computing_Bootcamp_Rubric.md).

## 1. Repository organisation and workflow discipline

- Your root README, `.gitignore`, cleaning script, test script and supplied data files are in the expected locations. The supplied CSV and metadata are unchanged, giving you a reproducible starting point.

## 2. Code completeness and functional correctness

- **Verify output creation.** I could not verify output creation from an empty results folder because `results/silwood_trees_clean.csv` was already committed. I could not compare newly generated outputs, and generated tables were unavailable for all three outputs. This does not mean that your tables are wrong or absent. Make a separate copy of your repository in a new folder using `git clone` and confirm that the generated CSV files are not already present. Run the workflow there, then inspect the newly written clean-record, issues and oak-summary tables. This will check whether the final writing stage preserves the data produced by your helpers.
- Check that the root README gives reproducible commands for running the script and tests, and explains the three outputs. Test the instructions in a newly cloned copy of your repository (a separate folder created with `git clone`): enter that folder and run each README command exactly as written. If something fails, correct the command or add the missing step.

## 3. Code quality and style

- Your `main()` function gives the program a clear overall structure by connecting loading, processing, summarising and writing. Keep these stages distinct as you revise; use descriptive names and add short comments where the reason for a validation check or data-cleaning step is not obvious.

## 4. Documentation

- Your root README is in place. Make it useful to someone opening the repository for the first time: explain what the cleaner does, how to run the script and tests from the repository root, and which three files it creates. Test the instructions in a newly cloned copy of your repository (a separate folder created with `git clone`): enter that folder and run each README command exactly as written. If something fails, correct the command or add the missing step.

## 5. Version-control practice

- Since the previous formative feedback was added, the saved history contains 2 non-merge commits. `add test script week2` identifies one useful addition, but `CMEECourseWork Week2` bundles the remaining work under a message that does not explain what changed.
- Before each commit, run `git diff --staged` to see exactly what will be recorded. Keep one coherent, working change per commit and write a concise message that names what changed—for example, the validation rule added, the failing test fixed or the README instruction clarified.
- `results/silwood_trees_clean.csv` is currently tracked by Git. After confirming that it is a generated file, run `git rm --cached results/silwood_trees_clean.csv`; this removes it from Git without deleting your local copy. Keep the results path in `.gitignore`, commit the change, and use `git status` to confirm that generated CSVs will not be included again.

## 8. Basic error handling and input validation

- Your required files are present, including the separate test file, root README and `.gitignore`. The supplied raw CSV and metadata remain unchanged.
- Your separate test file exercises record validation, the accepted/rejected partition and the oak summary using assertion-style checks. It ran successfully; now check the important edge cases and the contents of the written tables.
- **Extend testing through the writing stage.** Your tests cover several internal stages, but the current checks do not show the output-writing behaviour. Add a small end-to-end test using a few records whose accepted/rejected outcome you can explain. Read the written tables back and check their headers and consistency with the helper results. If this reveals a discrepancy, retain a focused regression test for it.
- Rerun the existing tests and cleaning script in a clean working copy, preserving the unchanged supplied inputs.

## 9. Problem-solving approach and method implementation

- Your code shows a connected workflow: `main()` loads the CSV through `load_records()`, sends rows to `process_records()` and `validate_record()`, receives accepted records and issues, passes the cleaned records to `summarise_oaks()`, then calls `write_csv()` three times. This structure makes the intended data route easy to follow.
- Before final submission, add or refine a small assertion-based test in `code/test_silwood_trees.py` using one valid and one invalid record. Check that `process_records()` places them in the cleaned and issues collections respectively, then pass the cleaned collection to `summarise_oaks()` and check that the invalid record does not contribute. Run the complete cleaner and inspect the three output files. Briefly explain this flow in your root README.
