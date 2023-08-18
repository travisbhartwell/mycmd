#!/usr/bin/env bash
# -*- mode: shell-script; sh-shell: bash; sh-basic-offset: 4; sh-indentation: 4; coding: utf-8 -*-
# shellcheck shell=bash

# This is going to be the simplest possible thing that could work
# until the full version is in MyCmd itself.

set -o nounset -o errexit -o errtrace -o pipefail

if ! PROJECT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P); then
    echo >&"Error fetching project directory."
    exit 1
fi

readonly BIN_DIR="${PROJECT_DIR}/bin"
readonly TEST_BASE="${PROJECT_DIR}/test"
readonly TEST_USER_BASE="${TEST_BASE}/user-base"
readonly SYSTEM_BASE="${PROJECT_DIR}/mycmd"
readonly VENDOR_DIR="${PROJECT_DIR}/vendor"
readonly VENDOR_WORKING_DIR="${PROJECT_DIR}/vendor/.working"

declare -ax ALL_FILES=("./project.sh" "./bin/mycmd" "./mycmd/mycmd-lib" "./mycmd/logging/logging-lib" "./mycmd/logging/log-both")

function format() {
    if (("${#ALL_FILES[@]}" == 0)); then
        echo >&2 "No files defined, skipping format."
        return 0
    fi

    echo "Formatting the following files:"
    echo "${ALL_FILES[*]}"

    cd "${PROJECT_DIR}"
    shfmt --language-dialect bash --indent=4 --binary-next-line --case-indent --write "${ALL_FILES[@]}"
}

function lint() {
    if (("${#ALL_FILES[@]}" == 0)); then
        echo >&2 "No files defined, skipping lint check."
        return 0
    fi

    echo "Linting the following files:"
    echo "${ALL_FILES[*]}"

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
    local return_code=$?

    /usr/bin/env -i MYCMD_SYSTEM_BASE_DIR="${MYCMD_SYSTEM_BASE_DIR:-${SYSTEM_BASE}}" \
        MYCMD_USER_BASE_DIR="${MYCMD_USER_BASE_DIR:-${TEST_USER_BASE}}" \
        PATH="${PATH}" \
        HOME="${HOME}" \
        "${BIN_DIR}"/mycmd "${@}" || return_code=$?
    exit "${return_code}"
}

function mycmd() {
    local return_code=0

    /usr/bin/env MYCMD_SYSTEM_BASE_DIR="${MYCMD_SYSTEM_BASE_DIR:-${SYSTEM_BASE}}" \
        MYCMD_USER_BASE_DIR="${MYCMD_USER_BASE_DIR:-${TEST_USER_BASE}}" \
        "${BIN_DIR}"/mycmd "${@}" || return_code=$?
    exit "${return_code}"
}

function test-command-directly() {
    local return_code=0

    /usr/bin/env MYCMD_SYSTEM_BASE_DIR="${MYCMD_SYSTEM_BASE_DIR:-${SYSTEM_BASE}}" \
        MYCMD_USER_BASE_DIR="${MYCMD_USER_BASE_DIR:-${TEST_USER_BASE}}" \
        PATH="${BIN_DIR}:${PATH}" \
        "${TEST_USER_BASE}/test-command" "${@}" || return_code=$?
    exit "${return_code}"
}

function test-command-outside-dir() {
    local return_code=0

    /usr/bin/env MYCMD_SYSTEM_BASE_DIR="${MYCMD_SYSTEM_BASE_DIR:-${SYSTEM_BASE}}" \
        MYCMD_USER_BASE_DIR="${MYCMD_USER_BASE_DIR:-${TEST_USER_BASE}}" \
        PATH="${BIN_DIR}:${PATH}" \
        "${TEST_BASE}/test-command-outside-dir" "${@}" || return_code=$?
    exit "${return_code}"
}

function mycmd-debugger() {
    local return_code=0
    /usr/bin/env MYCMD_SYSTEM_BASE_DIR="${MYCMD_SYSTEM_BASE_DIR:-${SYSTEM_BASE}}" \
        MYCMD_USER_BASE_DIR="${MYCMD_USER_BASE_DIR:-${TEST_USER_BASE}}" \
        bashdb "${BIN_DIR}"/mycmd "${@}" || return_code=$?
    exit "${return_code}"
}

function mycmd-no-env() {
    local return_code=0
    /usr/bin/env -i \
        PATH="${PATH}" \
        HOME="${HOME}" \
        "${BIN_DIR}"/mycmd "${@}" || return_code=$?
    exit "${return_code}"
}

function function_exists() {
    declare -F "$1" >/dev/null
}

function call_if_function_exists() {
    local -r fn=$1
    shift

    if function_exists "${fn}"; then
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
