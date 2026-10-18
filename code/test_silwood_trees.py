from clean_silwood_trees import validate_record

row = {
    "record_id": "ST001",
    "location": "Manor House",
    "genus": "Quercus",
    "species": "robur",
    "distance_m": "10",
    "angle_degrees": "10"
}

cleaned, reasons = validate_record(row, 2, set())

assert cleaned is not None
assert reasons == []
assert cleaned["record_id"] == "ST001"

bad_row = row.copy()
bad_row["record_id"] = "ST12"

cleaned, reasons = validate_record(bad_row, 3, set())
assert cleaned is None
assert reasons == ["invalid record_id"]

location_row = row.copy()
location_row["location"] = "  manor house  "

cleaned, reasons = validate_record(location_row, 4, set())

assert reasons == []
assert cleaned["location"] == "Manor House"

genus_row = row.copy()
genus_row["genus"] = "  QUERCUS  "

cleaned, reasons = validate_record(genus_row, 5, set())

assert reasons == []
assert cleaned["genus"] == "Quercus"

pair_row = row.copy()
pair_row["genus"] = "Acer"
pair_row["species"] = "robur"

cleaned, reasons = validate_record(pair_row, 6, set())

assert cleaned is None
assert reasons == ["invalid genus/species combination"]

distance_row = row.copy()
distance_row["distance_m"] = "101"


cleaned, reasons = validate_record(distance_row, 7, set())

assert cleaned is None
assert reasons == ["distance_m out of range"]

angle_row = row.copy()
angle_row["angle_degrees"] = "90"


cleaned, reasons = validate_record(angle_row, 8, set())

assert cleaned is None
assert reasons == ["angle_degrees out of range"]

nan_row = row.copy()
nan_row["distance_m"] = "nan"


cleaned, reasons = validate_record(nan_row, 9, set())

assert cleaned is None
assert reasons == ["invalid distance_m"]

inf_row = row.copy()
inf_row["distance_m"] = "inf"


cleaned, reasons = validate_record(inf_row, 10, set())

assert cleaned is None
assert reasons == ["invalid distance_m"]

duplicate_row = row.copy()

accepted_ids = {"ST001"}

cleaned, reasons = validate_record(duplicate_row, 11, accepted_ids)

assert cleaned is None
assert reasons == ["duplicate record_id"]

multi_row = row.copy()
multi_row["location"] = "Manner Housee"
multi_row["distance_m"] = "101"

cleaned, reasons = validate_record(multi_row, 12, set())

assert cleaned is None
assert reasons == [
    "invalid location",
    "distance_m out of range"
    ]

from clean_silwood_trees import process_records

row1 = row.copy()

row2 = row.copy()
row2["record_id"] = "ST002"
row2["location"] = "Manner Housee"
clean_records, issues = process_records([row1, row2])


assert len(clean_records) == 1
assert len(issues) == 1

from clean_silwood_trees import summarise_oaks

oak1 = row.copy()

oak2 = row.copy()
oak2["record_id"] = "ST002"

oak3 = row.copy()
oak3["record_id"] = "ST003"
oak3["species"] = "petraea"

oak_counts = summarise_oaks([oak1, oak2, oak3])

assert oak_counts == [
    {"species": "petraea", "count": "1"},
    {"species": "robur", "count": "2"}
]

