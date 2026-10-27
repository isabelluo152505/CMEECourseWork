# Assignment 3 formative feedback

This feedback is organised using the [Computing Bootcamp rubric](https://mulquabio.github.io/MQB/rubrics/Computing_Bootcamp_Rubric.html). It does not award a mark; use it to decide what to revise and check before final submission.

## Criterion 1: Repository organisation & workflow discipline

- Before final submission, **Make generated results reproducible rather than tracked.** Several generated files, including the required tree tables and Pound Hill outputs, are committed under `results/`; `.gitignore` currently covers only temporary files. This caused the ordinary-run checks to require review, not to establish failure or correctness. Stop tracking generated results while retaining local copies if needed, add an appropriate ignore rule, and confirm that each program recreates its outputs. In particular, `pound_hill_analysis.R` writes into `results/` without creating that directory, so it may depend on an earlier tree-height run. Make it able to run independently when that directory is absent.

## Criterion 2: Code completeness & functional correctness

Before final submission, run the fixed tree-height route, the generalised route and the Pound Hill analysis separately; check the exact files each one creates.

## Criterion 3: Code quality & style

As you revise, keep names descriptive, use comments to explain decisions rather than restating code, and avoid repeating the same calculation in several places.

## Criterion 4: Documentation

- All required paths are present, and the supplied input files match the supplied versions. Your root README covers Assignment 3’s purpose, inputs and intended outputs.
- Before final submission, **Correct the generalised-route instructions.** The README uses `Rscript code/run_get_TreeHeight.sh`, but this is a Bash script. Document and test it with Bash, and separately show how to pass another CSV to `get_TreeHeight.R`. Explain that commands run from the directory containing `code/`, `data/` and the root `README.md`; this avoids reliance on your personal filesystem path.

## Criterion 5: Version-control practice

Commit each functional revision with a short message that says what changed; this makes your development easier to follow than one large final commit.

## Criterion 8: Basic error-handling & input validation

- Your code shows the tree-height function takes angle first and horizontal distance second, converts degrees to radians and documents the units. Both tree programs contain numeric, finite-value and range checks. The invalid-input runs halted with distance-related error messages and the expected no-output behaviour.

## Criterion 9: Problem-solving approach & method implementation

- Your Pound Hill source follows a clear analytical route: species counts become quadrat richness, then plot-level mean richness. Your comments distinguish richness from abundance and appropriately caution that the figure alone does not establish causation. These are strengths in your code; the reported patterns still need checking against regenerated outputs.
- Before final submission, **Turn exploratory checks into evidence of correct outputs.** The fixed script prints `TreeHeight(45, 8)`, but does not record an independent comparison. Compare that call with a direct calculation, then trace one input row through each tree program to its saved height. For Pound Hill, manually count species present in one quadrat and follow it into the relevant plot mean. This checks both the data reshaping and the aggregation, rather than relying on a script finishing.

## Criterion 10: Learning progression demonstration

Use this feedback as a revision checklist. Make the changes in small, descriptive commits, then add a short README note explaining what you changed and how you checked it. This will make your development from this formative checkpoint visible in the final portfolio.

## Priorities before final submission

- From a clean working copy, run the fixed and generalised tree programs separately, each with one ordinary and one invalid case. Check the error message, exit behaviour and absence of a newly written result for invalid input; success in one route does not validate the other.
- Run Pound Hill independently. Check `results/pound_hill_plot_richness.csv` for the documented columns and one row per plot. Open `results/pound_hill_plot_richness.pdf` and check its labels, plotted values and biological interpretation against the table. Retain or revise your interpretation based on those checks.
- Update the README with the tested commands and brief diagnostic examples, then commit focused changes with descriptive messages.
