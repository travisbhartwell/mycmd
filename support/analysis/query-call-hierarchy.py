#!/usr/bin/env python3

import trace_logs

from pathlib import Path
import sys


def query_stack_frames(
    stack_frames: list[trace_logs.StackFrame], target_function: str
) -> tuple[set[tuple], set[str]]:
    related_stack_frames = [
        f for f in stack_frames if f.call_stack[-1] == target_function
    ]
    unique_call_stacks = set()
    unique_callers = set()

    for frame in related_stack_frames:
        call_stack = tuple(
            fn for fn in frame.call_stack if fn not in ["main", "source"]
        )
        unique_callers.add(call_stack[-2])
        unique_call_stacks.add(call_stack)

    return unique_call_stacks, unique_callers


def main():
    if len(sys.argv) < 3:
        print(
            "Usage: ./query-call-hierarchy.py <trace-log-file> <target_function>",
            file=sys.stderr,
        )
        sys.exit(1)

    trace_log_file = Path(sys.argv[1])

    if not trace_log_file.exists():
        print(f"Trace log file '{trace_log_file}' does not exist.", file=sys.stderr)
        sys.exit(1)

    target_function = sys.argv[2]

    stack_frames = trace_logs.load_stack_frames_from_trace_log(trace_log_file)

    unique_call_stacks, unique_callers = query_stack_frames(
        stack_frames, target_function
    )

    print(f"The following unique call stacks were found calling '{target_function}':")
    print("---------")

    for stack in unique_call_stacks:
        stack = list(stack)

        print(" -> ".join(stack))
        print("---------")

    print(f"The following unique callers called '{target_function}':")
    print("---------")

    for caller in sorted(unique_callers):
        print(f"{caller}")


if __name__ == "__main__":
    main()
