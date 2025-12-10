#
# Usage: source lib.sh
#

project_root="${ATM_PROJECT_ROOT:?}"
working_dir="${ATM_WORKING_DIR:-"$project_root/root"}"

t () {
    tofu -chdir="$working_dir" "$@"
}

get_host () {
    local node="${1:?}"
    local host

    host="$(t output -json vm_public_ips | jq -r --argjson n "$node" '.[$n]')"

    if [[ "$host" == "null" ]]; then
      fail "No public IP address found for the given node: %s" "$node"
    fi

    echo "$host"
}

get_public_key () {
    local node="${1:?}"
    local public_key

    public_key="$(t output -json vm_public_keys | jq -r --argjson n "$node" '.[$n]')"

    if [[ "$public_key" == "null" ]]; then
      fail "No public key found for the given node: %s" "$node"
    fi

    echo "$public_key"
}

get_private_key () {
    local node="${1:?}"
    local private_key

    private_key="$(t output -json vm_private_keys | jq -r --argjson n "$node" '.[$n]')"

    if [[ "$private_key" == "null" ]]; then
      fail "No private key found for the given node: %s" "$node"
    fi

    echo "$private_key"
}

fail () {
    local message="${1:?}"
    shift

    printf "Error: $message\n" "$@" >&2

    exit 1
}
