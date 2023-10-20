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
readonly PROJECT_DIR

readonly BIN_DIR="${PROJECT_DIR}/bin"
readonly TESTING_BASE="${PROJECT_DIR}/testing"
readonly TEST_FILES_BASE="${TESTING_BASE}/tests"
readonly TEST_USER_BASE="${TESTING_BASE}/user-base"
readonly SYSTEM_BASE="${PROJECT_DIR}/mycmd"
readonly VENDOR_DIR="${PROJECT_DIR}/vendor"
readonly TEST_VENDOR_DIR="${TESTING_BASE}/vendor"
readonly VENDOR_WORKING_DIR="${PROJECT_DIR}/vendor/.working"

function all-files-breadth-first() {
    # shellcheck disable=SC2312
    readarray -t ALL_FILES < <((
        echo -e "0\t${PROJECT_DIR}/project.sh"
        gfind "${BIN_DIR}" "${SYSTEM_BASE}" "${TEST_FILES_BASE}" "${TEST_USER_BASE}" -type f -printf '%d\t%p\n'
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
    /usr/bin/env MYCMD_SYSTEM_BASE_DIR="${MYCMD_SYSTEM_BASE_DIR:-${SYSTEM_BASE}}" \
        MYCMD_USER_BASE_DIR="${MYCMD_USER_BASE_DIR:-${TEST_USER_BASE}}" \
        MYCMD_VENDOR_DIR="${MYCMD_VENDOR_DIR:-${VENDOR_DIR}}" \
        PATH="${BIN_DIR}:${PATH}" \
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

function list-mycmd-lib-functions() {
    local -r mycmd_lib="${SYSTEM_BASE}/mycmd-lib"

    grep "^function" "${mycmd_lib}" | sed -n 's/function \(.*\)() {/\1/p'
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
    shellcheck --check-sourced "${ALL_FILES[@]}"
}

function _update_vendored_file_for_vendor_base_dir() {
    local -r source_path="${VENDOR_WORKING_DIR}/${1}"
    local -r vendor_dir="${2}"
    local -r dest_path="${vendor_dir}/${3}"
    local -r dest_dir=$(dirname "${dest_path}")

    if [[ ! -e "${source_path}" ]]; then
        echo >&2 "Source file '${source_path}' not found."
        return 1
    fi

    if [[ ! -e "${dest_dir}" ]]; then
        mkdir -p "${dest_dir}"
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

function _update_vendored_file() {
    _update_vendored_file_for_vendor_base_dir "${1}" "${VENDOR_DIR}" "${2}"
}

function _update_vendored_test_file() {
    _update_vendored_file_for_vendor_base_dir "${1}" "${TEST_VENDOR_DIR}" "${2}"
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

function update-shunit2() {
    # https://github.com/kward/shunit2/tree/master
    if [[ ! -e "${VENDOR_WORKING_DIR}/shunit2" ]]; then
        mkdir -p "${VENDOR_WORKING_DIR}" 2>/dev/null || true
        cd "${VENDOR_WORKING_DIR}"
        echo "Cloning shunit2 git repository."
        git clone --quiet git@github.com:kward/shunit2.git shunit2
    fi

    cd "${VENDOR_WORKING_DIR}/shunit2"
    echo "Pulling latest shunit2 changes from git."
    git pull --rebase --quiet

    _update_vendored_test_file "shunit2/shunit2" "shunit2"
    _update_vendored_test_file "shunit2/shunit2_test_helpers" "shunit2_test_helpers"
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

function list-tasks() {
    declare -F | grep -v \
        -e "^declare -f call_task" \
        -e "^declare -f function_exists" \
        -e "^declare -f _" \
        | sed 's/declare -f //' \
        | sort
}

function function_exists() {
    declare -F "$1" >/dev/null
}

function call_tasks() {
    for task in "${@}"; do
        local return_code=0

        call_task "${task}" || return_code=$?

        if ((return_code != 0)); then
            return "${return_code}"
        fi
    done
}

function call_task() {
    local -r fn=$1
    shift

    cd "${PROJECT_DIR}"

    local return_code=0
    if function_exists "${fn}"; then
        echo "➡️ Executing task '${fn}'..."

        "${fn}" "$@" || return_code=$?
    else
        echo >&2 "Unknown task: '${fn}'."
        return_code=1
    fi

    if ((return_code == 0)); then
        echo "✅ Task '${fn}' succeeded."
    else
        echo "❌ Task '${fn}' failed."
    fi

    return "${return_code}"
}

if (($# == 0)); then
    echo >&2 "Expecting task to run:"
    echo >&2 "$0 <task>"
    exit 1
fi

call_task "${@}"
