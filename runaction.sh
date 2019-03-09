#!/bin/bash

cd "$GITHUB_WORKSPACE" || exit 1
find . -name \*.sh -exec shellcheck {} +