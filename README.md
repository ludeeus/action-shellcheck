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
    - uses: actions/checkout@main
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

## Run shellcheck with all paths in a single invocation

If you run into SC1090/SC1091 errors you may need to tell shellcheck to check
all files at once:

```yaml
    ...
    - name: Run ShellCheck
    uses: ludeeus/action-shellcheck@master
    with:
      check_together: 'yes'
```

This can turn into a problem if you have enough script files to overwhelm the
maximum argv length on your system.
