# ShellCheck

_GitHub action for ShellCheck._

## Example

```yaml
on:
  push:
    branches:
      - master

name: "Trigger: Push action"

jobs:
  shellcheck:
    name: Shellcheck
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run ShellCheck
        uses: ludeeus/action-shellcheck@master
```

## ShellCheck options

You can pass any supported ShellCheck option or flag with the `SHELLCHECK_OPTS` env key in the job definition.

Some examples include:

- To disable specific checks (eg: `-e SC2059 -e SC2034 -e SC1090`)
- To test against different shells (eg: `-s dash` or `-s ksh`)

example:

```yaml
    ...
    - name: Run ShellCheck
      uses: ludeeus/action-shellcheck@master
      env:
        SHELLCHECK_OPTS: -e SC2059 -e SC2034 -e SC1090
```

## Ignore paths and names

You can use the `ignore_paths` and `ignore_names` input to disable specific directories and files.

```text
sample structure:
sample/directory/with/files/ignoreme/test.sh
sample/directory/with/files/ignoremetoo/test.sh
sample/directory/with/files/test.sh
sample/directory/with/files/ignorable.sh
```

example:

```yaml
    ...
    - name: Run ShellCheck
      uses: ludeeus/action-shellcheck@master
      with:
        ignore_paths: ignoreme ignoremetoo
        ignore_names: ignorable.sh
```

This will skip `sample/directory/with/files/ignoreme/test.sh`, `sample/directory/with/files/ignoremetoo/test.sh` and `sample/directory/with/files/ignorable.sh`.

You can also ignore specific files using full paths or glob patterns with `ignore_paths`.

example:

```yaml
    ...
    - name: Run ShellCheck
      uses: ludeeus/action-shellcheck@master
      with:
        ignore_paths: ./sample/directory/with/files/ignorable.sh **/ignoreme/test.sh
```

This will skip `sample/directory/with/files/ignorable.sh` and `sample/directory/with/files/ignoreme/test.sh`.

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

## Run shellcheck only in a single directory

If you have multiple directories with scripts, but only want to scan
one of them, you can use the following configuration:

```yaml
   ...
   - name: Run ShellCheck
     uses: ludeeus/action-shellcheck@master
     with:
       scandir: './scripts'
```

## Scan for additional files

If you need to scan for unusual files, you can use the `additional_files` key.

```yaml
   ...
   - name: Run ShellCheck
     uses: ludeeus/action-shellcheck@master
     with:
       additional_files: 'run finish'
```

## Disable problem matcher

If you do not want to have the problem-matcher annotate files, you can disable it
by setting `disable_matcher` to `true`.

```yaml
   ...
   - name: Run ShellCheck
     uses: ludeeus/action-shellcheck@master
     with:
       disable_matcher: true
```

## Change output format

Shellcheck can print output in these formats: `checkstyle`, `diff`, `gcc`, `json`, `json1`, `quiet`, `tty`. See some examples [here](https://github.com/koalaman/shellcheck/wiki/Integration#pick-the-output-format-that-makes-your-life-easier).
Only `tty` and `gcc` produce file annotations via problem matcher, default is `gcc`.

- `tty` has multi-line log messages, but all annotations are reported as errors
- `gcc` has single-line log messages, so it's easier to parse with a problem matcher (including correct severity annotation)

```yaml
   ...
   - name: Run ShellCheck
     uses: ludeeus/action-shellcheck@master
     with:
       format: tty
```

## Run a specific version of Shellcheck

If running the latest stable version of Shellcheck is not to your liking, you can specify a concrete version of Shellcheck to be used. When specifying a custom version, please use any of the released versions listed in the [Shellcheck repository](https://github.com/koalaman/shellcheck/tags).

```yaml
   ...
   - name: Run ShellCheck
     uses: ludeeus/action-shellcheck@master
     with:
       version: v0.7.0
```
