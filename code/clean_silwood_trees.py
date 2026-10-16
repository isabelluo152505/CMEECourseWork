#!/usr/bin/env python3
"""Validate and clean the synthetic Silwood tree survey."""

from __future__ import annotations

import csv
import math
from pathlib import Path
from typing import Iterable


PROJECT_ROOT = Path(__file__).resolve().parents[1]
INPUT_PATH = PROJECT_ROOT / "data" / "silwood_trees_raw.csv"
RESULTS_DIR = PROJECT_ROOT / "results"

INPUT_FIELDS = [
    "record_id",
    "location",
    "genus",
    "species",
    "distance_m",
    "angle_degrees",
]
ISSUE_FIELDS = ["source_row", "record_id", "reasons"]
OAK_COUNT_FIELDS = ["species", "count"]


def load_records(path: Path = INPUT_PATH) -> list[dict[str, str]]:
    """Read the survey and check its column names."""
    with path.open(newline="", encoding="utf-8") as source:
        reader = csv.DictReader(source)
        if reader.fieldnames != INPUT_FIELDS:
            raise ValueError(
                f"Expected columns {INPUT_FIELDS}, found {reader.fieldnames}"
            )
        return list(reader)


def validate_record(
    row: dict[str, str],
    source_row: int,
    accepted_ids: set[str],
) -> tuple[dict[str, str] | None, list[str]]:
    """Clean one record, or return the reasons it cannot be used."""

    reasons = []
    cleaned = {}

    record_id = row["record_id"].strip()
    if not record_id:
        reasons.append("missing record_id")

    elif record_id[:2] != "ST" or len(record_id) !=5:
        reasons.append("invalid record_id")
    else:
        for digit in record_id[2:]:
            if digit not in "0123456789":
                reasons.append("invalid record_id")
                break
    if record_id in accepted_ids:
            reasons.append("duplicate record_id")

    location = row["location"].strip()
    

    locations = [
        "Silwood Bottom",
        "Nash's Field",
        "Manor House",
        "Reactor Wood"
    ]
    if not location:
            reasons.append("missing location")
    else:
        matched_location = None

        for place in locations:
            if location.lower() == place.lower():
                matched_location = place 
                break
    if matched_location is None:
            reasons.append("invalid location")
    else:
            cleaned["location"] = matched_location

    genus = row["genus"].strip()
    species = row["species"].strip()



    

    genera = ["Quercus", "Acer", "Betula", "Fagus", "Fraxinus"]
    matched_genus = None

    if not genus:
        reasons.append("missing genus")
    else:
        for name in genera:
            if genus.lower() == name.lower():
                matched_genus = name 
                break
    if matched_genus is None:
        reasons.append("invalid genus")
    else:
        cleaned["genus"] = matched_genus

    species_names = [
    "robur",
    "petraea",
    "pseudoplatanus",
    "pendula",
    "sylvatica",
    "excelsior"
    ]

    if not species:
        reasons.append("missing species")
    else:
        matched_species = None
    
        for name in species_names:
            if species.lower() == name.lower():
                matched_species = name 
                break
        if matched_species is None:
           reasons.append("invalid species")
        else:
           cleaned["species"] = matched_species

    valid_pairs = [
    ("Quercus", "robur"),
    ("Quercus", "petraea"),
    ("Acer", "pseudoplatanus"),
    ("Betula", "pendula"),
    ("Fagus", "sylvatica"),
    ("Fraxinus", "excelsior")
    ]

    if "genus" in cleaned and "species" in cleaned:
        pair = (cleaned["genus"], cleaned["species"])

        if pair not in valid_pairs:
            reasons.append("invalid genus/species combination")

    distance_text = row["distance_m"].strip()

    if not distance_text:
        reasons.append("missing distance_m")
    else:
        try:
            distance = float(distance_text)

            if not math.isfinite(distance):
                 reasons.append("invalid distance_m")
            elif distance <= 0 or distance > 100:
                 reasons.append("distance_m out of range")
            else:
                 cleaned["distance_m"] = str(distance)

        except ValueError:
            reasons.append("invalid distance_m")

  
    angle_text = row["angle_degrees"].strip()
    
    if not angle_text:
        reasons.append("missing angle_degrees")
    else:
        try:
            angle = float(angle_text)
    
            if not math.isfinite(angle):
                     reasons.append("invalid angle_degrees")
            elif angle <= 0 or angle >= 90:
                     reasons.append("angle_degrees out of range")
            else:
                 cleaned["angle_degrees"] = str(angle)
    
        except ValueError:
            reasons.append("invalid angle_degrees")
    if reasons:
         return None, reasons
    cleaned["record_id"] = record_id
    return cleaned, []




def process_records(
    rows: Iterable[dict[str, str]],
) -> tuple[list[dict[str, str]], list[dict[str, str]]]:
    """Sort records into accepted rows and issue reports."""
    clean_records = []
    issues = []
    accepted_ids = set()
    for source_row, row in enumerate(rows, start=2):
        cleaned, reasons = validate_record(row, source_row, accepted_ids)
        if cleaned is not None:
            clean_records.append(cleaned)
            accepted_ids.add(cleaned["record_id"])
        else:
            issue = {
            "source_row": str(source_row),
            "record_id": row["record_id"].strip(),
            "reasons": "; ".join(reasons)
            }
            issues.append(issue)
    def get_record_id(record):
        return record["record_id"]

    clean_records.sort(key=get_record_id)
    return clean_records, issues
    


def summarise_oaks(clean_records: Iterable[dict[str, str]]) -> list[dict[str, str]]:
    """Count accepted oak records by species."""
    counts = {}
    for record in clean_records:
        if record["genus"] == "Quercus":
            species = record["species"]
            if species in counts:
                counts[species] += 1
            else:
                counts[species] = 1
    oak_counts = []

    for species in sorted(counts):
        oak_counts.append({
            "species": species,
            "count": str(counts[species])
        })

    return oak_counts


def write_csv(
    path: Path,
    fieldnames: list[str],
    rows: Iterable[dict[str, str]],
) -> None:
    """Write rows to a CSV file, replacing an older copy."""
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="", encoding="utf-8") as destination:
        writer = csv.DictWriter(destination, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)


def main() -> None:
    """Clean the survey and write the three result files."""
    clean_records, issues = process_records(load_records())
    oak_counts = summarise_oaks(clean_records)

    write_csv(
        RESULTS_DIR / "silwood_trees_clean.csv",
        INPUT_FIELDS,
        clean_records,
    )
    write_csv(
        RESULTS_DIR / "silwood_tree_issues.csv",
        ISSUE_FIELDS,
        issues,
    )
    write_csv(
        RESULTS_DIR / "oak_species_counts.csv",
        OAK_COUNT_FIELDS,
        oak_counts,
    )


if __name__ == "__main__":
    main()
