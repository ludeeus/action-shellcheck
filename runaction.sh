#!/bin/bash

cd "$GITHUB_WORKSPACE" || exit 1

declare statuscode
declare -a filepaths
declare -a excludes
declare -a tmp

statuscode=0

excludes+=( ! -path *./.git/* )
excludes+=( ! -path *.go )

for path in ${INPUT_IGNORE}; do
    echo "::debug:: Adding '${path}' to excludes"
    excludes+=(! -path "*./${path}/*" )
    excludes+=(! -path "*/${path}/*" )
done

readarray -d '' filepaths < <(find . "${excludes[@]}" \
    '(' \
    \
    -name '*.bash' \
    -o -path '*/.bash*' \
    -o -path '*/bash*' \
    -o -name '*.ksh' \
    -o -name 'ksh*' \
    -o -path '*/.ksh*' \
    -o -path '*/ksh*' \
    -o -name 'suid_profile' \
    -o -name '*.zsh' \
    -o -name '.zlogin*' \
    -o -name 'zlogin*' \
    -o -name '.zlogout*' \
    -o -name 'zlogout*' \
    -o -name '.zprofile*' \
    -o -name 'zprofile*' \
    -o -path '*/.zsh*' \
    -o -path '*/zsh*' \
    -o -name '*.sh' \
    -o -path '*/.profile*' \
    -o -path '*/.shlib*' \
    -o -path '*/shlib*' \
       ')'\
    \
    -print0)


readarray -d '' tmp < <(find . "${excludes[@]}" -type f ! -name '*.*' -perm /111  -print0)
for file in "${tmp[@]}"; do
    head -n1 "$file" | grep -Eqs "^#! */[^ ]*/[abkz]*sh" || continue
    filepaths+=("$file")
done

if  find . "${excludes[@]}" -path '*bin/*/*' -type f -perm /111 -print |
    grep .
then
    echo >&2 "::warning:: subdirectories of bin directories are not usable via PATH"
fi

if  find . "${excludes[@]}" -path '*bin/*' -name '*.*' -type f -perm /111 -perm /444 -print |
    grep .
then
    echo >&2 "::warning:: programs in PATH should not have a filename suffix"
fi

for file in "${filepaths[@]}"; do
    echo "::debug:: Checking $file"
    shellcheck "$file" || statuscode=$?
done

exit "$statuscode"