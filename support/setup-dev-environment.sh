#!/usr/bin/env bash

readonly GIT_REPO_URL=git@github.com:travisbhartwell/mycmd.git

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

function install_snapshot() {
    local -r base_git_dir="${1}"
    local -r bin_dir="${base_git_dir}/bin"
    local -r system_dir="${base_git_dir}/mycmd"
    local -r user_dir="${HOME}/mycmd"

    cd "${base_git_dir}" || return 1

    if [[ ! -d "${user_dir}" ]]; then
        mkdir -p "${user_dir}"
    fi

    /usr/bin/env MYCMD_SYSTEM_BASE_DIR="${system_dir}" \
        PATH="${bin_dir}:${PATH}" \
        "${bin_dir}"/mycmd project run \
        update-snapshot-worktree-to-latest-development-snapshot
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

    install_snapshot "${base_repo_dir}"
}

main "${@}"
