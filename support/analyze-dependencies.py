#!/usr/bin/env python3

from collections import defaultdict
from csv import DictReader
from pathlib import Path


def load_function_call_counts(fn_callers_csv: Path) -> dict[str, dict[str, int]]:
    function_call_counts = defaultdict(lambda: defaultdict(int))

    with fn_callers_csv.open() as f:
        reader = DictReader(f)
        for row in reader:
            if row["count"] != "0":
                function_call_counts[row["function"]][row["file"]] += int(row["count"])
    return function_call_counts


def load_function_index(fn_index_csv: Path) -> dict[str, str]:
    function_index = {}
    with fn_index_csv.open() as f:
        reader = DictReader(f)
        for row in reader:
            function_index[row["function"]] = row["file"]
    return function_index


def unused_functions(function_call_counts: dict[str, dict[str, int]], function_index: dict[str, str]) -> list[str]:
    unused_functions = []
    for function, file in function_index.items():
        if function not in function_call_counts:
            unused_functions.append(f"{file}:{function}")
    return unused_functions


def file_dependencies(function_call_counts: dict[str, dict[str, int]], function_index: dict[str, str]) -> dict[str, list[str]]:
    file_dependencies = defaultdict(set)

    for function, call_counts in function_call_counts.items():
        for file, _ in call_counts.items():
            file_dependencies[file].add(function_index[function])

    return file_dependencies


if __name__ == "__main__":
    function_call_counts = load_function_call_counts(Path("./tmp/fn-call-counts.csv"))
    function_index = load_function_index(Path("./tmp/all-functions.csv"))
    unused_functions = unused_functions(function_call_counts, function_index)
    file_dependencies = file_dependencies(function_call_counts, function_index)

    print("Unused functions:")
    print("\n".join(unused_functions))

    print("\nFile dependencies:")
    for file, dependencies in file_dependencies.items():
        print(f"{file}:")
        for d in dependencies:
            print(f"\t{d}")