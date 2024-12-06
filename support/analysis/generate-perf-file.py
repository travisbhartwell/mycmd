#!/usr/bin/env python3

import trace_logs

from pathlib import Path
import sys


def write_perf_file(stack_frames: list[trace_logs.StackFrame], perf_file_name: Path):
    with perf_file_name.open("w") as f:
        for frame in stack_frames:
            if frame.call_stack != [""]:
                call_stack = ";".join(frame.call_stack)
                microseconds = int(frame.duration.total_seconds() * 1_000_000)

                f.write(f"{call_stack} {microseconds}\n")


def generate_perf_file(trace_log_file: Path, perf_file: Path):
    stack_frames = trace_logs.load_stack_frames_from_trace_log(trace_log_file)
    write_perf_file(stack_frames, perf_file)


def main():
    if len(sys.argv) < 3:
        print(
            "Usage: ./generate-perf-file.py <trace-log-file> <perf-output-file>",
            file=sys.stderr,
        )
        sys.exit(1)

    trace_log_file = Path(sys.argv[1])

    if not trace_log_file.exists():
        print(f"Trace log file '{trace_log_file}' does not exist.", file=sys.stderr)
        sys.exit(1)

    perf_file = Path(sys.argv[2])

    generate_perf_file(trace_log_file, perf_file)


if __name__ == "__main__":
    main()
