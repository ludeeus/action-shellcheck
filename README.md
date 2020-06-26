# ShellCheck

_GitHub action for ShellCheck._

## Example

```yaml
on:
  push:
    branch:
      - master

name: 'Trigger: Push action'

jobs:
  shellcheck:
    name: Shellcheck
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: Run ShellCheck
      uses: ludeeus/action-shellcheck@master
```

## Globally disable checks

To disable specific checks add it to a `SHELLCHECK_OPTS` env key in the job definition.

example:

```yaml
    ...
    - name: Run ShellCheck
      uses: ludeeus/action-shellcheck@master
      env:
        SHELLCHECK_OPTS: -e SC2059 -e SC2034 -e SC1090
```

## Ignore paths

You can use the `ignore` input to disable specific directories.

```text
sample structure:
sample/directory/with/files/toignore/test.sh
sample/directory/with/files/test.sh
```

example:

```yaml
    ...
    - name: Run ShellCheck
      uses: ludeeus/action-shellcheck@master
      with:
        ignore: toignore
```

This will skip `sample/directory/with/files/toignore/test.sh`

## Minimum severity of errors to consider (error, warning, info, style)

You can use the `severity` input to not fail until specified severity is met, for example fail only if there are errors in scripts but ignore styling, info and warnings.

example:

```yaml
    ...
    - name: Run ShellCheck
      uses: ludeeus/action-shellcheck@master
      with:
        severity: error
```
