#!/bin/bash

cd "$GITHUB_WORKSPACE" || exit 1
find . -name \*.sh -exec shellcheck {} +
find . -name \*.bashrc -exec shellcheck {} +
find . -name \*.bash_profile -exec shellcheck {} +