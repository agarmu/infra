default:
    @just --list

# Install provider and create dependency lock file
init:
    tofu init

# Format configuration and documentation
fmt:
    tofu fmt -recursive
    nixfmt shell.nix
    shfmt -w -ln bash .envrc
    mdformat README.md
    yamlfmt .pre-commit-config.yaml .yamllint.yaml

# Run all pre-commit checks
check:
    prek run --all-files

# Validate configuration
validate:
    tofu validate

# Preview changes
plan:
    tofu plan

# Preview and apply after interactive confirmation
apply:
    tofu apply
