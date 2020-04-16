# SHELLCHECK

_Run shellcheck on ALL shell files in the repository._

## Example

```
name: Shell Lint

on:
  pull_request:
    types: ['opened', 'edited', 'reopened', 'synchronize']

jobs:
  shellcheck:
    name: Shell Check
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@master
      - name: Check Shell Files
        uses: AutoGravity/shellcheck-action@v0.0.0
	env:
	  EXCLUDE_DIRS:
	    - node_modules
	    - tmp
```
