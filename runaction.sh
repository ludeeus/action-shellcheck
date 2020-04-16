#!/bin/bash

cd "$GITHUB_WORKSPACE" || exit

EXCLUDES=()

for dir in ${EXCLUDE_DIRS}; do
   # all find results start with './'
   [[ ${dir#./*} != "$dir" ]] || dir="./${dir}"
   EXCLUDES+=(! -path "$dir/*" -a)
done

printf "debug: %s\n" "excludes='${EXCLUDES[*]}'"

find \
   . "${EXCLUDES[@]}" \
   '(' \
         -name '*.bash'       \
      -o -path '*/.bash*'     \
      -o -path '*/bash*'      \
      -o -name '*.ksh'        \
      -o -name 'ksh*'         \
      -o -path '*/.ksh*'      \
      -o -path '*/ksh*'       \
      -o -name 'suid_profile' \
      -o -name '*.zsh'        \
      -o -name '.zlogin*'     \
      -o -name 'zlogin*'      \
      -o -name '.zlogout*'    \
      -o -name 'zlogout*'     \
      -o -name '.zprofile*'   \
      -o -name 'zprofile*'    \
      -o -path '*/.zsh*'      \
      -o -path '*/zsh*'       \
      -o -name '*.sh'         \
      -o -path '*/.profile*'  \
      -o -path '*/profile*'   \
      -o -path '*/.shlib*'    \
      -o -path '*/shlib*'     \
   ')' \
   -exec shellcheck {} + || exit

exit

# shellcheck disable=SC2016
find . "${EXCLUDES[@]}" -type f ! -name '*.*' -perm /111 -exec sh -c '
   for f; do
      head -n1 "$f" | grep -Eqs "^#! */[^ ]*/[abkz]*sh" || continue
      shellcheck "$f" || err=$?
   done
   exit $err
   ' _ {} + || exit

if  find . "${EXCLUDES[@]}" -path '*bin/*/*' -type f -perm /111 -print |
   grep .
then
   echo >&2 "WARNING: subdirectories of bin directories are not usable via PATH"
fi

if  find . "${EXCLUDES[@]}" -path '*bin/*' -name '*.*' -type f -perm /111 -perm /444 -print |
   grep .
then
   echo >&2 "WARNING: programs in PATH should not have a filename suffix"
fi
