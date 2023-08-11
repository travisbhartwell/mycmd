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

declare -ax ALL_FILES=("./project.sh" "./bin/mycmd" "./mycmd/mycmd-lib")

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
    shellcheck --check-sourced "${ALL_FILES[@]}"
}

function update-bashup-events() {
    # Full Repo URL: https://github.com/bashup/events/tree/bash44
    # Clone URL: git@github.com:bashup/events.git
    curl -sSL https://raw.githubusercontent.com/bashup/events/bash44/bashup.events -o "${VENDOR_DIR}/bashup.events"
}

function mycmd() {
    local return_code=$?
    MYCMD_SYSTEM_BASE_DIR="${MYCMD_SYSTEM_BASE_DIR:-${SYSTEM_BASE}}" \
        MYCMD_USER_BASE_DIR="${MYCMD_USER_BASE_DIR:-${TEST_USER_BASE}}" \
        "${BIN_DIR}"/mycmd "${@}" || return_code=$?
    exit "${return_code}"
}

function mycmd-no-env() {
    local return_code=$?
    /usr/bin/env -u MYCMD_SYSTEM_BASE_DIR -u MYCMD_USER_BASE_DIR "${BIN_DIR}"/mycmd "${@}" || return_code=$?
    exit "${return_code}"
}

if (($# == 0)); then
    echo >&2 "Expecting task to run:"
    echo >&2 "$0 <task>"
    exit 1
fi

"${@}"
