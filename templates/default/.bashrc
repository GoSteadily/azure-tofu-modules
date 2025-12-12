#
# Useful for you to customize your local development environment.
#
# This script is sourced the first time you enter the development environment.
#

t () {
  tofu -chdir="$PROJECT_ROOT/root" "$@"
}

ts () {
  tofu -chdir="$PROJECT_ROOT/storage" "$@"
}

export -f t ts
