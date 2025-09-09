#!/usr/bin/env bash

if [[ -n "${MYCMD_USE_GIT_HTTPS-}" ]]; then
    readonly GIT_REPO_URL=https://github.com/travisbhartwell/mycmd.git
else
    readonly GIT_REPO_URL=git@github.com:travisbhartwell/mycmd.git
fi

function absolute_dir_path() {
    local -r p="${1}"

    if [[ ! -d "${p}" ]]; then
        return 1
    fi

    cd "${p}" &>/dev/null && pwd -P
}

function setup_base_git_repo() {
    local -r base_dir="${1}"
    local -r branch_to_start="${2}"

    cd "${base_dir}" || return 1

    git clone -b "${branch_to_start}" "${GIT_REPO_URL}" "${branch_to_start}"
}

function set_environment_for_mycmd() {
    local -r base_git_dir="${1}"
    local -r bin_dir="${base_git_dir}/bin"
    local -r system_dir="${base_git_dir}/mycmd"
    local -r user_dir="${HOME}/mycmd"

    cd "${base_git_dir}" || return 1

    if [[ ! -d "${user_dir}" ]]; then
        mkdir -p "${user_dir}"
    fi

    export MYCMD_SYSTEM_BASE_DIR="${system_dir}"

    echo >&2 "Set MYCMD_SYSTEM_BASE_DIR to '${MYCMD_SYSTEM_BASE_DIR}'"

    export PATH="${bin_dir}":${PATH}

    echo >&2 "Set PATH to: '${PATH}'"
}

readonly MYPROJECT_SETUP_DEV_ENVIRONMENT_URL="https://raw.githubusercontent.com/travisbhartwell/myproject/main/support/setup-dev-environment.sh"
readonly MYPROJECT_SETUP_DEV_ENVIRONMENT="setup-myproject-dev-environment.sh"

function install_myproject() {
    local -r parent_dir="${1}"
    local -r branch_to_start="${2}"

    cd "${parent_dir}" || return 1

    echo >&2 "In ${parent_dir}, and downloading script from '${MYPROJECT_SETUP_DEV_ENVIRONMENT_URL}'"

    curl -sSL -o "${MYPROJECT_SETUP_DEV_ENVIRONMENT}" "${MYPROJECT_SETUP_DEV_ENVIRONMENT_URL}" && chmod +x "${MYPROJECT_SETUP_DEV_ENVIRONMENT}"

    if [[ -n "${MYCMD_USE_GIT_HTTPS-}" ]]; then
        MYPROJECT_USE_GIT_HTTPS=1 ./"${MYPROJECT_SETUP_DEV_ENVIRONMENT}" "${parent_dir}" "${branch_to_start}"
    else
        ./"${MYPROJECT_SETUP_DEV_ENVIRONMENT}" "${parent_dir}" "${branch_to_start}"
    fi

    rm "${MYPROJECT_SETUP_DEV_ENVIRONMENT}"
}

function set_environment_for_myproject() {
    local -r parent_dir="${1}"
    local -r myproject_snapshot_mycmd_lib_dir="${parent_dir}/myproject/snapshot/mycmd"

    export MYCMD_SEARCH_PATH="${myproject_snapshot_mycmd_lib_dir}"
    echo >&2 "Set MYCMD_SEARCH_PATH to '${MYCMD_SEARCH_PATH}'"
}

function install_snapshot() {
    local -r base_git_dir="${1}"

    cd "${base_git_dir}" || return 1

    echo >&2 "Installing the MyCmd snapshot."

    mycmd myproject run repo update-snapshot-worktree-to-latest-development-snapshot
}

function main() {
    if (($# == 0)); then
        echo >&2 "$0 <parent directory> [branch to start]"
        exit 1
    fi

    local parent_dir
    if ! parent_dir="$(absolute_dir_path "${1}")"; then
        echo >&2 "Error getting absolute path for '${1}'"
        exit 1
    fi
    readonly parent_dir

    local base_dir="${parent_dir}/mycmd"

    if [[ -d "${base_dir}" ]]; then
        echo >&2 "'${base_dir}' already exists, not overwriting."
        exit 1
    fi

    echo >&2 "Using '${base_dir}' to set up MyCmd checkouts."
    mkdir -p "${base_dir}"

    local -r branch_to_start="${2-main}"
    echo >&2 "Using '${branch_to_start}' to start."

    setup_base_git_repo "${base_dir}" "${branch_to_start}"

    local -r base_repo_dir="${base_dir}/${branch_to_start}"

    set_environment_for_mycmd "${base_repo_dir}"

    install_myproject "${parent_dir}" "${branch_to_start}"

    set_environment_for_myproject "${parent_dir}"

    install_snapshot "${base_repo_dir}"

    echo "Please add '${base_dir}/snapshot/bin' to your PATH to make 'mycmd' available."
}

main "${@}"
