from dataclasses import dataclass
from datetime import datetime, timedelta
from pathlib import Path
import re
import sys
from typing import Any, Optional

log_line_re = re.compile(
    r"^(?P<subshell>\++)\[(?P<epochrealtime>.+)\]\[(?P<filename>[^:]+):(?P<line>.\d+)\]:\[(?P<call_stack>.*)\]:(?P<code>.*)$"
)


@dataclass(frozen=True)
class TraceLine:
    subshell: int
    timestamp: datetime
    filename: Path
    line_no: int
    code: str
    call_stack: list[str]
    duration: Optional[timedelta] = None
    function: Optional[str] = None


def trace_line(
    match: dict[str, str | Any], next_match: Optional[dict[str, str | Any]] = None
) -> TraceLine:
    subshell = match.get("subshell", "").count("+")
    epochrealtime = match.get("epochrealtime")
    if epochrealtime == None:
        raise RuntimeError("Missing epochrealtime")

    timestamp = datetime.fromtimestamp(float(epochrealtime))
    if next_match is not None:
        next_epochrealtime = next_match.get("epochrealtime")
        if next_epochrealtime == None:
            raise RuntimeError("Missing epochrealtime in next_match")
        next_timestamp = datetime.fromtimestamp(float(next_epochrealtime))
        duration = next_timestamp - timestamp
    else:
        duration = None

    filename = Path(str(match.get("filename", "")))
    line_no = int(match.get("line", 0))
    code = match.get("code", "")
    call_stack = match.get("call_stack", "").split(" ")
    call_stack.reverse()
    function = call_stack[0] if len(call_stack) > 0 else None

    return TraceLine(
        subshell, timestamp, filename, line_no, code, call_stack, duration, function
    )


def get_trace_lines(trace_log_file: Path) -> list[TraceLine]:
    lines = []

    with trace_log_file.open() as f:
        for line in f:
            if match := log_line_re.match(line):
                lines.append(match.groupdict())

    trace_lines = []

    for match, next_match in zip(lines, lines[1:]):
        trace_lines.append(trace_line(match, next_match))

    return trace_lines


@dataclass(frozen=True)
class StackFrame:
    call_stack: list[str]
    duration: timedelta


def get_stack_frames(trace_lines: list[TraceLine]) -> list[StackFrame]:
    stack_frames = []

    duration = (
        trace_lines[0].duration if trace_lines[0].duration is not None else timedelta(0)
    )
    call_stack = trace_lines[0].call_stack

    for tl in trace_lines[1:]:
        if tl.call_stack != call_stack:
            stack_frames.append(StackFrame(call_stack, duration))
            call_stack = tl.call_stack
            duration = tl.duration
        elif tl.duration is not None:
            duration += tl.duration

    return stack_frames


def load_stack_frames_from_trace_log(trace_log_file: Path) -> list[StackFrame]:
    trace_lines = get_trace_lines(trace_log_file)
    stack_frames = get_stack_frames(trace_lines)
    return stack_frames
