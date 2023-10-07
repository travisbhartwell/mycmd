#!/usr/bin/env bash
# -*- mode: shell-script; sh-shell: bash; sh-basic-offset: 4; sh-indentation: 4; coding: utf-8 -*-
# shellcheck shell=bash

# This is going to be the simplest possible thing that could work
# until the full version is in MyCmd itself.

set -o nounset -o errexit -o errtrace -o pipefail

if ! PROJECT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P); then
    echo >&2 "Error fetching project directory."
    exit 1
fi

readonly BIN_DIR="${PROJECT_DIR}/bin"
readonly TESTING_BASE="${PROJECT_DIR}/testing"
readonly TEST_FILES_BASE="${TESTING_BASE}/tests"
readonly TEST_USER_BASE="${TESTING_BASE}/user-base"
readonly SYSTEM_BASE="${PROJECT_DIR}/mycmd"
readonly VENDOR_DIR="${PROJECT_DIR}/vendor"
readonly VENDOR_WORKING_DIR="${PROJECT_DIR}/vendor/.working"

function all-files-breadth-first() {
    # shellcheck disable=SC2312
    readarray -t ALL_FILES < <((
        echo -e "0\t${PROJECT_DIR}/project.sh"
        gfind "${BIN_DIR}" "${SYSTEM_BASE}" "${TESTING_BASE}" -type f -printf '%d\t%p\n'
    ) | sort -nk1 | cut -f2- | xargs grealpath --relative-to="${PROJECT_DIR}")
}

declare -ax ALL_FILES=()
all-files-breadth-first
readonly ALL_FILES

function all-test-files-breadth-first() {
    # shellcheck disable=SC2312
    readarray -t ALL_TEST_FILES < <((
        gfind "${TEST_FILES_BASE}" -type f -name '*-test' -printf '%d\t%p\n'
    ) | sort -nk1 | cut -f2- | xargs grealpath --relative-to="${PROJECT_DIR}")
}

declare -ax ALL_TEST_FILES=()
all-test-files-breadth-first
readonly ALL_TEST_FILES

function list-files() {
    echo "${*}" | tr ' ' '\n'
}

function list-all-test-files() {
    list-files "${ALL_TEST_FILES[*]}"
}

function list-all-files() {
    list-files "${ALL_FILES[*]}"
}

function summarize_test_results() {
    local -n results_ref="${1}"

    (
        echo "Testing Summary:"
        echo "| Result | Test File |"
        echo "|--------|-----------|"
        local test_file
        local result

        for test_file in "${!results_ref[@]}"; do
            result="${results_ref["${test_file}"]}"
            if ((result == 0)); then
                echo "| ✅︎ | ${test_file} |"
            else
                echo "| ❌ | ${test_file} |"
            fi
        done
    ) | gum format --type=markdown
}

function _execute-test() {
    local -r test_file="${1}"

    if [[ ! -e "${test_file}" ]]; then
        echo "Test file not found: ${test_file}"
        return 1
    fi

    local result=0
    echo "Executing test file: ${test_file}"
    "${test_file}" || result=$?

    echo "Result of ${test_file}: ${result}"
    return "${result}"
}

function execute-all-tests() {
    local test_file
    local -A results=()
    local result

    for test_file in "${ALL_TEST_FILES[@]}"; do
        result=0

        _execute-test "${test_file}" || result=$?
        # shellcheck disable=SC2034
        results["${test_file}"]="${result}"
    done

    summarize_test_results results
}

function format() {
    if (("${#ALL_FILES[@]}" == 0)); then
        echo >&2 "No files defined, skipping format."
        return 0
    fi

    echo "Formatting the following files:"
    list-all-files

    cd "${PROJECT_DIR}"
    shfmt --language-dialect bash --indent=4 --binary-next-line --case-indent --write "${ALL_FILES[@]}"
}

function lint() {
    if (("${#ALL_FILES[@]}" == 0)); then
        echo >&2 "No files defined, skipping lint check."
        return 0
    fi

    echo "Linting the following files:"
    list-all-files

    cd "${PROJECT_DIR}"
    echo "Running ShellCheck:"
    shellcheck --check-sourced "${ALL_FILES[@]}" && echo "Success"
}

function _update_vendored_file() {
    local -r source_path="${VENDOR_WORKING_DIR}/${1}"
    local -r dest_path="${VENDOR_DIR}/${2}"

    if [[ ! -e "${source_path}" ]]; then
        echo >&2 "Source file '${source_path}' not found."
        return 1
    fi

    if [[ -e "${dest_path}" ]]; then
        if diff -q "${source_path}" "${dest_path}"; then
            echo "Vendored file '${dest_path}' is up to date."
            return 0
        fi
    fi

    echo "Updating vendor destination '${dest_path}'."
    cp -a "${source_path}" "${dest_path}"
}

function update-ansi() {
    # https://github.com/fidian/ansi
    if [[ ! -e "${VENDOR_WORKING_DIR}/ansi" ]]; then
        mkdir -p "${VENDOR_WORKING_DIR}" 2>/dev/null || true
        cd "${VENDOR_WORKING_DIR}"
        echo "Cloning ansi git repository."
        git clone --quiet git@github.com:fidian/ansi.git
    fi

    cd "${VENDOR_WORKING_DIR}/ansi"
    echo "Pulling latest ansi changes from git."
    git pull --rebase --quiet

    _update_vendored_file "ansi/ansi" "ansi"
}

function update-bashup-events() {
    # https://github.com/bashup/events/tree/bash44
    if [[ ! -e "${VENDOR_WORKING_DIR}/bashup.events" ]]; then
        mkdir -p "${VENDOR_WORKING_DIR}" 2>/dev/null || true
        cd "${VENDOR_WORKING_DIR}"
        echo "Cloning bashup.events git repository."
        git clone --quiet -b bash44 git@github.com:bashup/events.git bashup.events
    fi

    cd "${VENDOR_WORKING_DIR}/bashup.events"
    echo "Pulling latest bashup.events changes from git."
    git pull --rebase --quiet

    _update_vendored_file "bashup.events/bashup.events" "bashup.events"
}

function mycmd-minimal-env() {
    /usr/bin/env -i MYCMD_SYSTEM_BASE_DIR="${MYCMD_SYSTEM_BASE_DIR:-${SYSTEM_BASE}}" \
        MYCMD_USER_BASE_DIR="${MYCMD_USER_BASE_DIR:-${TEST_USER_BASE}}" \
        PATH="${PATH}" \
        HOME="${HOME}" \
        "${BIN_DIR}"/mycmd "${@}"
}

function mycmd() {
    /usr/bin/env MYCMD_SYSTEM_BASE_DIR="${MYCMD_SYSTEM_BASE_DIR:-${SYSTEM_BASE}}" \
        MYCMD_USER_BASE_DIR="${MYCMD_USER_BASE_DIR:-${TEST_USER_BASE}}" \
        "${BIN_DIR}"/mycmd "${@}"
}

function test-command-directly() {
    /usr/bin/env MYCMD_SYSTEM_BASE_DIR="${MYCMD_SYSTEM_BASE_DIR:-${SYSTEM_BASE}}" \
        MYCMD_USER_BASE_DIR="${MYCMD_USER_BASE_DIR:-${TEST_USER_BASE}}" \
        PATH="${BIN_DIR}:${PATH}" \
        "${TEST_USER_BASE}/test-command" "${@}"
}

function test-command-outside-dir() {
    /usr/bin/env MYCMD_SYSTEM_BASE_DIR="${MYCMD_SYSTEM_BASE_DIR:-${SYSTEM_BASE}}" \
        MYCMD_USER_BASE_DIR="${MYCMD_USER_BASE_DIR:-${TEST_USER_BASE}}" \
        PATH="${BIN_DIR}:${PATH}" \
        "${TESTING_BASE}/test-command-outside-dir" "${@}"
}

function migrate-command-group() {
    /usr/bin/env MYCMD_SYSTEM_BASE_DIR="${MYCMD_SYSTEM_BASE_DIR:-${SYSTEM_BASE}}" \
        MYCMD_USER_BASE_DIR="${MYCMD_USER_BASE_DIR:-${TEST_USER_BASE}}" \
        PATH="${BIN_DIR}:${PATH}" \
        "${SYSTEM_BASE}/migrate/command-group" "${@}"
}

function migrate-command() {
    /usr/bin/env MYCMD_SYSTEM_BASE_DIR="${MYCMD_SYSTEM_BASE_DIR:-${SYSTEM_BASE}}" \
        MYCMD_USER_BASE_DIR="${MYCMD_USER_BASE_DIR:-${TEST_USER_BASE}}" \
        PATH="${BIN_DIR}:${PATH}" \
        "${SYSTEM_BASE}/migrate/command" "${@}"
}

function mycmd-debugger() {
    /usr/bin/env MYCMD_SYSTEM_BASE_DIR="${MYCMD_SYSTEM_BASE_DIR:-${SYSTEM_BASE}}" \
        MYCMD_USER_BASE_DIR="${MYCMD_USER_BASE_DIR:-${TEST_USER_BASE}}" \
        bashdb "${BIN_DIR}"/mycmd "${@}"
}

function mycmd-no-env() {
    /usr/bin/env -i \
        PATH="${PATH}" \
        HOME="${HOME}" \
        "${BIN_DIR}"/mycmd "${@}"
}

function function_exists() {
    declare -F "$1" >/dev/null
}

function call_if_function_exists() {
    local -r fn=$1
    shift

    if function_exists "${fn}"; then
        echo >&2 "Executing task: ${fn}..."
        "${fn}" "$@"
    else
        echo >&2 "Unknown task: '${fn}'."
    fi
}

if (($# == 0)); then
    echo >&2 "Expecting task to run:"
    echo >&2 "$0 <task>"
    exit 1
fi

call_if_function_exists "${@}"
