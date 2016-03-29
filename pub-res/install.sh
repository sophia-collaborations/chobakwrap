
pubresdir="$(cd "$(dirname "${0}")" && pwd)"


cd "${1}" || exit
curdirec="$(pwd)"

if [ -f "proj-info/proj-name.txt" ]; then
  fildesnom="$(cat "proj-info/proj-name.txt")"
  echo "Project Identified: ${fildesnom}:"
else
  (
    echo
    echo PROJECT NAME NOT FOUND
    echo "$(pwd)/proj-info/proj-name.txt"
    echo
  ) > /dev/stderr
  exit 3
fi


if [ -f "Makefile" ]; then
  make all || exit
  # IMPORTANT: The file 'all' should *obviously* never be created.
  # It is merely an anchor for all else that must be built.
  # All targets that actually *are* subjected to writing and/or
  # alteration must be within the 'build' directory, so that they
  # will not be tracked by Git.
fi


rm -rf tmp
mkdir -p tmp

rm -rf tmp/checkret.txt
perl "${pubresdir}/ins-pl/checkbefore.pl"
if [ -f "tmp/checkret.txt" ]; then
  exit "$(cat tmp/checkret.txt)"
fi


(
  echo "#! $(which perl)"
  echo "use strict;"
  echo "my \$resloc = \"${curdirec}\";"
  echo "# line 1 \"${pubresdir}/outer-wrap.qpl-then\""
  cat "${pubresdir}/outer-wrap.qpl"
) > tmp/${fildesnom}
chmod 755 tmp/${fildesnom}
perl -c tmp/${fildesnom} || exit 2

destina="${HOME}/bin"
# Allow overriding of default:
if [ -f "ins-opt-code/dir-of-install.txt" ]; then
  destina="$(cat ins-opt-code/dir-of-install.txt)"
fi

cp "tmp/${fildesnom}" "${destina}/."
chmod 755 "${destina}/${fildesnom}"

if [ -f "after-install.sh" ]; then
  exec sh after-install.sh
fi

# Prepare environment for extra compilation instructions:

MY_DESTINA_BIN="${destina}"
export MY_DESTINA_BIN

if [ -f "extra-install.sh" ]; then
  exec sh extra-install.sh
fi





